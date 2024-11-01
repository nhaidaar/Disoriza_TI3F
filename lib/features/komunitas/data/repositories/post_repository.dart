import 'package:appwrite/appwrite.dart';
import 'package:disoriza/features/auth/data/models/user_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class PostRepository {
  Future<Either<AppwriteException, void>> createPost({required UserModel user});

  Future<String> uploadFile();
}
