import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/comment_model.dart';
import '../../../domain/usecases/komunitas_usecase.dart';

part 'komunitas_comment_event.dart';
part 'komunitas_comment_state.dart';

class KomunitasCommentBloc extends Bloc<KomunitasCommentEvent, KomunitasCommentState> {
  final KomunitasUsecase _komunitasUsecase;
  KomunitasCommentBloc(this._komunitasUsecase) : super(KomunitasCommentInitial()) {
    on<KomunitasFetchComments>((event, emit) async {
      try {
        emit(KomunitasCommentLoading());

        final response = await _komunitasUsecase.fetchComments(
          postId: event.postId,
          latest: event.latest,
        );

        response.fold(
          (error) => emit(KomunitasCommentError(message: error.toString().split(': ').last)),
          (success) => emit(KomunitasCommentLoaded(commentModels: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasCreateComment>((event, emit) async {
      try {
        final response = await _komunitasUsecase.createComment(comment: event.comment);
        response.fold(
          (error) => emit(KomunitasCommentError(message: error.toString().split(': ').last)),
          (success) {},
        );

        add(KomunitasFetchComments(postId: event.comment.idPost.toString()));
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasDeleteComment>((event, emit) async {
      try {
        final response = await _komunitasUsecase.deleteComment(commentId: event.commentId);
        response.fold(
          (error) => emit(KomunitasCommentError(message: error.toString().split(': ').last)),
          (success) => emit(KomunitasCommentDeleted()),
        );
        add(KomunitasFetchComments(postId: event.postId));
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasLikeComment>((event, emit) async {
      try {
        final response = await _komunitasUsecase.likeComment(
          uid: event.uid,
          commentId: event.commentId,
        );

        response.fold(
          (error) => emit(KomunitasCommentError(message: error.toString().split(': ').last)),
          (success) {},
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasUnlikeComment>((event, emit) async {
      try {
        final response = await _komunitasUsecase.unlikeComment(
          uid: event.uid,
          commentId: event.commentId,
        );

        response.fold(
          (error) => emit(KomunitasCommentError(message: error.toString().split(': ').last)),
          (success) {},
        );
      } catch (_) {
        rethrow;
      }
    });
  }
}
