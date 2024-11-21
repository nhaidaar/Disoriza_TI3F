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
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (email != null) updates['email'] = email;

      if (updates.isEmpty) {
        return Left(Exception("No updates provided."));
      }

      final response = await client
          .from('users')
          .update(updates)
          .eq('id', uid)
          .select()
          .single();
          
      final updatedUser = UserModel.fromMap(response);
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
