import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/post_model.dart';
import '../../../domain/usecases/komunitas_usecase.dart';

part 'komunitas_post_event.dart';
part 'komunitas_post_state.dart';

class KomunitasPostBloc extends Bloc<KomunitasPostEvent, KomunitasPostState> {
  final KomunitasUsecase _komunitasUsecase;
  KomunitasPostBloc(this._komunitasUsecase) : super(KomunitasPostInitial()) {
    on<KomunitasFetchPosts>((event, emit) async {
      try {
        emit(KomunitasPostLoading());

        final response = await _komunitasUsecase.fetchAllPosts(
          latest: event.latest,
          max: event.max,
        );
        response.fold(
          (error) => emit(KomunitasPostError(message: error.toString())),
          (success) => emit(KomunitasPostLoaded(postModels: success)),
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
          (error) => emit(KomunitasPostError(message: error.toString())),
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
          (error) => emit(KomunitasPostError(message: error.toString())),
          (success) {
            emit(KomunitasPostCreated());
            add(const KomunitasFetchPosts());
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
          (error) => emit(KomunitasPostError(message: error.toString())),
          (success) {
            emit(KomunitasPostDeleted());
            add(const KomunitasFetchPosts());
          },
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
          (error) => emit(KomunitasPostError(message: error.toString())),
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
          (error) => emit(KomunitasPostError(message: error.toString())),
          (success) {},
        );
      } catch (_) {
        rethrow;
      }
    });
  }
}