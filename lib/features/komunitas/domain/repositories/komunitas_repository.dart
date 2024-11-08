import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';

abstract class KomunitasRepository {
  Future<Either<AppwriteException, List<PostModel>>> fetchAllPosts({
    bool latest = false,
  });

  Future<Either<AppwriteException, List<PostModel>>> fetchAktivitas({
    required User user,
    required String filter,
  });

  Future<Either<AppwriteException, void>> createPost({
    required PostModel post,
  });

  Future<Either<AppwriteException, void>> deleteAllPosts();

  Future<Either<AppwriteException, void>> likePost({
    required String uid,
    required PostModel post,
  });

  Future<Either<AppwriteException, List<CommentModel>>> fetchComments({
    required String postId,
    bool latest = false,
  });

  Future<Either<AppwriteException, void>> createComment({
    required CommentModel comment,
  });

  Future<Either<AppwriteException, void>> likeComment({
    required String uid,
    required CommentModel comment,
  });
}
