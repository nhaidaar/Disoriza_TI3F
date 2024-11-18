import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/post_model.dart';
import '../../../domain/usecases/komunitas_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final KomunitasUsecase _komunitasUsecase;
  PostCubit(this._komunitasUsecase) : super(PostInitial());

  Future<void> fetchAllPosts({
    bool latest = false,
    int? max,
  }) async {
    try {
      emit(PostLoading());

      final response = await _komunitasUsecase.fetchAllPosts(
        latest: latest,
        max: max,
      );
      response.fold(
        (error) => emit(PostError(message: error.toString())),
        (success) => emit(PostLoaded(postModels: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> fetchAktivitas({
    required String uid,
    required String filter,
  }) async {
    try {
      emit(PostLoading());

      final response = await _komunitasUsecase.fetchAktivitas(
        uid: uid,
        filter: filter,
      );
      response.fold(
        (error) => emit(PostError(message: error.toString())),
        (success) => emit(PostLoaded(postModels: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> createPost({required PostModel post}) async {
    try {
      emit(PostLoading());

      final response = await _komunitasUsecase.createPost(post: post);
      response.fold(
        (error) => emit(PostError(message: error.toString())),
        (success) {
          emit(CreatePostSuccess());
          fetchAllPosts();
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> likePost({
    required String uid,
    required String postId,
  }) async {
    try {
      final response = await _komunitasUsecase.likePost(
        uid: uid,
        postId: postId,
      );

      response.fold(
        (error) => emit(PostError(message: error.toString())),
        (success) {},
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> unlikePost({
    required String uid,
    required String postId,
  }) async {
    try {
      final response = await _komunitasUsecase.unlikePost(
        uid: uid,
        postId: postId,
      );

      response.fold(
        (error) => emit(PostError(message: error.toString())),
        (success) {},
      );
    } catch (_) {
      rethrow;
    }
  }
}
