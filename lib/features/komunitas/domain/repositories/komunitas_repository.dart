import 'package:fpdart/fpdart.dart';

import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';

abstract class KomunitasRepository {
  Future<Either<Exception, List<PostModel>>> fetchAllPosts({
    bool latest = false,
    int? max,
  });

  Future<Either<Exception, List<PostModel>>> fetchAktivitas({
    required String uid,
    required String filter,
  });

  Future<Either<Exception, void>> createPost({required PostModel post});

  Future<Either<Exception, void>> likePost({
    required String uid,
    required String postId,
  });

  Future<Either<Exception, void>> unlikePost({
    required String uid,
    required String postId,
  });

  Future<Either<Exception, List<CommentModel>>> fetchComments({
    required String postId,
    bool latest = false,
  });

  Future<Either<Exception, void>> createComment({
    required CommentModel comment,
  });

  Future<Either<Exception, void>> likeComment({
    required String uid,
    required String commentId,
  });

  Future<Either<Exception, void>> unlikeComment({
    required String uid,
    required String commentId,
  });
}
