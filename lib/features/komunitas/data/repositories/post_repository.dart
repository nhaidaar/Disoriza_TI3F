import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

abstract class PostRepository {
  Future<Either<AppwriteException, User>> createPost();
}