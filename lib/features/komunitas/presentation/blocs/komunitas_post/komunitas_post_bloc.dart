import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/post_model.dart';
import '../../../data/models/post_with_comment.dart';
import '../../../domain/usecases/komunitas_usecase.dart';

part 'komunitas_post_event.dart';
part 'komunitas_post_state.dart';

class KomunitasPostBloc extends Bloc<KomunitasPostEvent, KomunitasPostState> {
  final KomunitasUsecase _komunitasUsecase;
  KomunitasPostBloc(this._komunitasUsecase) : super(KomunitasPostInitial()) {
    on<KomunitasFetchAllPosts>((event, emit) async {
      try {
        emit(KomunitasPostLoading());

        final response = await _komunitasUsecase.fetchAllPosts(
          latest: event.latest,
          max: event.max,
        );
        response.fold(
          (error) => emit(KomunitasPostError(message: error.toString().split(': ').last)),
          (success) => emit(KomunitasPostLoaded(postModels: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasFetchReportedPosts>((event, emit) async {
      try {
        emit(KomunitasPostLoading());

        final response = await _komunitasUsecase.fetchReportedPosts();
        response.fold(
          (error) => emit(KomunitasPostError(message: error.toString().split(': ').last)),
          (success) => emit(KomunitasPostLoaded(postModels: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasFetchReportedComments>((event, emit) async {
      try {
        emit(KomunitasPostLoading());

        final response = await _komunitasUsecase.fetchReportedComments();
        response.fold(
          (error) => emit(KomunitasPostError(message: error.toString().split(': ').last)),
          (success) => emit(KomunitasPostWithCommentLoaded(commentWithPost: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasFetchAktivitas>((event, emit) async {
      try {
        emit(KomunitasPostLoading());

        final response = await _komunitasUsecase.fetchAktivitas(
          uid: event.uid,
          filter: event.filter,
        );
        response.fold(
          (error) => emit(KomunitasPostError(message: error.toString().split(': ').last)),
          (success) => emit(KomunitasPostLoaded(postModels: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasCreatePost>((event, emit) async {
      try {
        emit(KomunitasPostLoading());

        final response = await _komunitasUsecase.createPost(
          title: event.title,
          description: event.description,
          uid: event.uid,
          image: event.image,
        );
        response.fold(
          (error) => emit(KomunitasPostError(message: error.toString().split(': ').last)),
          (success) {
            emit(KomunitasPostCreated());
            add(const KomunitasFetchAllPosts());
          },
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasDeletePost>((event, emit) async {
      try {
        emit(KomunitasPostLoading());

        final response = await _komunitasUsecase.deletePost(postId: event.postId);
        response.fold(
          (error) => emit(KomunitasPostError(message: error.toString().split(': ').last)),
          (success) => emit(KomunitasPostDeleted()),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasLikePost>((event, emit) async {
      try {
        final response = await _komunitasUsecase.likePost(
          uid: event.uid,
          postId: event.postId,
        );

        response.fold(
          (error) => emit(KomunitasPostError(message: error.toString().split(': ').last)),
          (success) {},
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasUnlikePost>((event, emit) async {
      try {
        final response = await _komunitasUsecase.unlikePost(
          uid: event.uid,
          postId: event.postId,
        );

        response.fold(
          (error) => emit(KomunitasPostError(message: error.toString().split(': ').last)),
          (success) {},
        );
      } catch (_) {
        rethrow;
      }
    });
  }
}
