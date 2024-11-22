import 'package:fpdart/fpdart.dart';

import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';
import '../repositories/komunitas_repository.dart';

class KomunitasUsecase {
  final KomunitasRepository _komunitasRepository;
  const KomunitasUsecase(this._komunitasRepository);

  Future<Either<Exception, List<PostModel>>> fetchAllPosts({
    bool latest = false,
    int? max,
  }) {
    return _komunitasRepository.fetchAllPosts(
      latest: latest,
      max: max,
    );
  }

  Future<Either<Exception, List<PostModel>>> fetchAktivitas({
    required String uid,
    required String filter,
  }) {
    return _komunitasRepository.fetchAktivitas(
      uid: uid,
      filter: filter,
    );
  }

  Future<Either<Exception, void>> createPost({required PostModel post}) {
    return _komunitasRepository.createPost(post: post);
  }

  Future<Either<Exception, void>> deletePost({required String postId}) {
    return _komunitasRepository.deletePost(postId: postId);
  }

  Future<Either<Exception, void>> likePost({
    required String uid,
    required String postId,
  }) {
    return _komunitasRepository.likePost(
      uid: uid,
      postId: postId,
    );
  }

  Future<Either<Exception, void>> unlikePost({
    required String uid,
    required String postId,
  }) {
    return _komunitasRepository.unlikePost(
      uid: uid,
      postId: postId,
    );
  }

  Future<Either<Exception, List<CommentModel>>> fetchComments({
    required String postId,
    bool latest = false,
  }) {
    return _komunitasRepository.fetchComments(
      postId: postId,
      latest: latest,
    );
  }

  Future<Either<Exception, void>> createComment({required CommentModel comment}) {
    return _komunitasRepository.createComment(comment: comment);
  }

  Future<Either<Exception, void>> deleteComment({required String commentId}) {
    return _komunitasRepository.deleteComment(commentId: commentId);
  }

  Future<Either<Exception, void>> likeComment({
    required String uid,
    required String commentId,
  }) {
    return _komunitasRepository.likeComment(
      uid: uid,
      commentId: commentId,
    );
  }

  Future<Either<Exception, void>> unlikeComment({
    required String uid,
    required String commentId,
  }) {
    return _komunitasRepository.unlikeComment(
      uid: uid,
      commentId: commentId,
    );
  }
}
