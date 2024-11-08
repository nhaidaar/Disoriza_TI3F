import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';
import '../repositories/komunitas_repository.dart';

class KomunitasUsecase {
  final KomunitasRepository _komunitasRepository;
  const KomunitasUsecase(this._komunitasRepository);

  Future<Either<AppwriteException, List<PostModel>>> fetchAllPosts({
    bool latest = false,
  }) {
    return _komunitasRepository.fetchAllPosts(
      latest: latest,
    );
  }

  Future<Either<AppwriteException, List<PostModel>>> fetchAktivitas({
    required User user,
    required String filter,
  }) {
    return _komunitasRepository.fetchAktivitas(
      user: user,
      filter: filter,
    );
  }

  Future<Either<AppwriteException, void>> createPost({
    required PostModel post,
  }) {
    return _komunitasRepository.createPost(post: post);
  }

  Future<Either<AppwriteException, void>> deleteAllPosts() async {
    return _komunitasRepository.deleteAllPosts();
  }

  Future<Either<AppwriteException, void>> likePost(
      {required String uid, required PostModel post}) async {
    return _komunitasRepository.likePost(
      uid: uid,
      post: post,
    );
  }

  Future<Either<AppwriteException, List<CommentModel>>> fetchComments({
    required String postId,
    bool latest = false,
  }) async {
    return _komunitasRepository.fetchComments(postId: postId, latest: latest);
  }

  Future<Either<AppwriteException, void>> createComment({
    required CommentModel comment,
  }) async {
    return _komunitasRepository.createComment(comment: comment);
  }

  Future<Either<AppwriteException, void>> likeComment({
    required String uid,
    required CommentModel comment,
  }) async {
    return _komunitasRepository.likeComment(
      uid: uid,
      comment: comment,
    );
  }
}
