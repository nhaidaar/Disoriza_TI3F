import 'package:fpdart/fpdart.dart';

import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserModel>> checkSession();

  Future<Either<Exception, UserModel>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Exception, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Exception, void>> logout();
}
