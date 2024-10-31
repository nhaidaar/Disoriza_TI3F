import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:disoriza/features/auth/domain/repositories/auth_repository.dart';
// import 'package:disoriza/features/user/data/models/user_model.dart';

class AuthUsecase {
  final AuthRepository _authRepository;

  const AuthUsecase(this._authRepository);

  Future<Either<AppwriteException, User>> checkSession() async {
    return _authRepository.checkSession();
  }

  Future<Either<AppwriteException, User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return _authRepository.register(name: name, email: email, password: password);
  }

  Future<Either<AppwriteException, Session>> login({
    required String email,
    required String password,
  }) async {
    return _authRepository.login(email: email, password: password);
  }

  Future<Either<AppwriteException, void>> logout() {
    return _authRepository.logout();
  }
}
