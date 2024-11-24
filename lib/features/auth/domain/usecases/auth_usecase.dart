import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';

import '../repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

class AuthUsecase {
  final AuthRepository _authRepository;

  const AuthUsecase(this._authRepository);

  Future<Either<Exception, UserModel>> checkSession() async {
    return _authRepository.checkSession();
  }

  Future<Either<Exception, UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return _authRepository.register(name: name, email: email, password: password);
  }

  Future<Either<Exception, UserModel>> login({
    required String email,
    required String password,
  }) async {
    return _authRepository.login(email: email, password: password);
  }

  Future<Either<Exception, void>> logout() {
    return _authRepository.logout();
  }

  Future<Either<Exception, void>> resetPassword({required String email}) {
    return _authRepository.resetPassword(email: email);
  }

  Future<Either<Exception, UserModel>> editProfile({
    required String uid,
    String? name,
    Uint8List? image,
  }) async {
    return _authRepository.editProfile(
      uid: uid,
      name: name,
      image: image,
    );
  }

  Future<Either<Exception, void>> changeEmail({required String email}) {
    return _authRepository.changeEmail(email: email);
  }
}
