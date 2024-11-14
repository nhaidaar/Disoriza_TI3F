// ignore_for_file: void_checks

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:disoriza/features/auth/domain/repositories/auth_repository.dart';

import '../../../user/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Client client;
  const AuthRepositoryImpl({required this.client});

  @override
  Future<Either<AppwriteException, User>> checkSession() async {
    try {
      final user = await Account(client).get();
      return Right(user);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final account = await Account(client).create(
        userId: ID.unique(),
        name: name,
        email: email,
        password: password,
      );

      await Databases(client).createDocument(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_USER_COLLECTION_ID"),
        documentId: account.$id,
        data: UserModel(
          name: name,
          email: email,
        ).toMap(),
      );

      return Right(account);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, Session>> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await Account(client).createEmailPasswordSession(
        email: email,
        password: password,
      );
      return Right(session);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> logout() async {
    try {
      final clearedSession = await Account(client).deleteSession(
        sessionId: 'current',
      );
      return Right(clearedSession);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }
}
