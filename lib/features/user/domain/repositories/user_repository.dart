import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<AppwriteException, UserModel>> fetchUserModel({
    required String uid,
  });

  // Future<Either<Exception, bool>> checkEmailExists({required String email});
}
