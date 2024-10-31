import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<AppwriteException, User>> checkSession();

  Future<Either<AppwriteException, User>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<AppwriteException, Session>> login({
    required String email,
    required String password,
  });

  Future<Either<AppwriteException, void>> logout();
}
