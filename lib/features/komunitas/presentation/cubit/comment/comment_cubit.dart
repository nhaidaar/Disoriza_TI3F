import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/comment_model.dart';
import '../../../domain/usecases/komunitas_usecase.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final KomunitasUsecase _komunitasUsecase;
  CommentCubit(this._komunitasUsecase) : super(CommentInitial());

  Future<void> fetchComments({
    required String postId,
    bool latest = false,
  }) async {
    try {
      emit(CommentLoading());

      final response = await _komunitasUsecase.fetchComments(
        postId: postId,
        latest: latest,
      );

      response.fold(
        (error) => emit(CommentError(message: error.toString())),
        (success) => emit(CommentLoaded(commentModels: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> createComment({required CommentModel comment}) async {
    try {
      final response = await _komunitasUsecase.createComment(comment: comment);
      response.fold(
        (error) => emit(CommentError(message: error.toString())),
        (success) {},
      );

      await fetchComments(postId: comment.idPost.toString());
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteComment({
    required String postId,
    required String commentId,
  }) async {
    try {
      final response = await _komunitasUsecase.deleteComment(commentId: commentId);
      response.fold(
        (error) => emit(CommentError(message: error.toString())),
        (success) => emit(DeleteCommentSuccess()),
      );

      await fetchComments(postId: postId);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> likeComment({
    required String uid,
    required String commentId,
  }) async {
    try {
      final response = await _komunitasUsecase.likeComment(
        uid: uid,
        commentId: commentId,
      );

      response.fold(
        (error) => emit(CommentError(message: error.toString())),
        (success) {},
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> unlikeComment({
    required String uid,
    required String commentId,
  }) async {
    try {
      final response = await _komunitasUsecase.unlikeComment(
        uid: uid,
        commentId: commentId,
      );

      response.fold(
        (error) => emit(CommentError(message: error.toString())),
        (success) {},
      );
    } catch (_) {
      rethrow;
    }
  }
}
