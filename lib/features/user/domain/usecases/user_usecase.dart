import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';

class UserUsecase {
  final UserRepository _userRepository;
  const UserUsecase(this._userRepository);

  Future<Either<AppwriteException, UserModel>> fetchUserModel({
    required String uid,
  }) {
    return _userRepository.fetchUserModel(uid: uid);
  }

  // Future<Either<Exception, bool>> checkEmailExists({required String email}) {
  //   return _userRepository.checkEmailExists(email: email);
  // }
}
