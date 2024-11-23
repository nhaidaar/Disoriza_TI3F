import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:disoriza/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient client;
  const AuthRepositoryImpl({required this.client});

  @override
  Future<Either<Exception, UserModel>> checkSession() async {
    try {
      final user = client.auth.currentSession;
      if (user == null) return Left(Exception());

      final userModel = await fetchUserModel(uid: user.user.id);
      if (userModel != null) return Right(userModel);

      return Right(UserModel.fromMap(user.user.toJson()));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<UserModel?> fetchUserModel({required String uid}) async {
    try {
      final user = await client.from('users').select().eq('id', uid).single();
      if (user.isNotEmpty) return UserModel.fromMap(user);
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<Exception, UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final account = await client.auth.signUp(
        email: email,
        password: password,
      );
      await client.from('users').insert({
        'id': account.user?.id,
        'name': name,
        'email': email,
      });

      return Right(UserModel(
        id: account.user?.id,
        name: name,
        email: email,
      ));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (session.user == null) return Left(Exception('Error login!'));

      final userModel = await fetchUserModel(uid: session.user!.id);
      if (userModel != null) return Right(userModel);

      return Right(UserModel.fromMap(session.user!.toJson()));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> logout() async {
    try {
      final clearedSession = await client.auth.signOut();
      return Right(clearedSession);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> resetPassword({required String email}) async {
    try {
      await client.auth.resetPasswordForEmail(email);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, UserModel>> edit({
    required String uid,
    String? name,
    String? email,
    Uint8List? profilePicture,
  }) async {
    try {
      final time = DateTime.now().millisecondsSinceEpoch;
      final path = '/$uid/$time.png';

      String? url;
      
      // Check if the user is updating their profile picture
      if (profilePicture != null) {
        // If the user already has a profile picture, delete the old one
        // final userResponse = await client
        //     .from('users')
        //     .select('profile_picture')
        //     .eq('id', uid)
        //     .single();
        
        // final currentProfilePicture = userResponse['profile_picture'];
        // if (currentProfilePicture != null) {
        //   // Delete the current profile picture from storage
        //   final oldProfilePicturePath = Uri.parse(currentProfilePicture).path;
        //   await client.storage.from('user_profile').remove([oldProfilePicturePath]);
        // }

        // Upload the new profile picture
        await client.storage.from('user_profile').uploadBinary(path, profilePicture);
        url = client.storage.from('user_profile').getPublicUrl(path);
      }

      // Prepare the update fields
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (email != null) updates['email'] = email;
      if (profilePicture != null) updates['profile_picture'] = url;

      if (updates.isEmpty) {
        return Left(Exception("No updates provided."));
      }

      // Update the user's information in the database
      final response = await client
          .from('users')
          .update(updates)
          .eq('id', uid)
          .select()
          .single();

      final updatedUser = UserModel.fromMap(response);

      // Update the user's email in Supabase auth
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(email: email),
      );

      return Right(updatedUser);
    } on PostgrestException catch (e) {
      return Left(Exception(e.message));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
