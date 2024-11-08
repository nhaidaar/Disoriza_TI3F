import 'package:appwrite/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/post_model.dart';
import '../../../domain/usecases/komunitas_usecase.dart';

part 'komunitas_state.dart';

class KomunitasCubit extends Cubit<KomunitasState> {
  final KomunitasUsecase _komunitasUsecase;
  KomunitasCubit(this._komunitasUsecase) : super(KomunitasInitial());

  Future<void> fetchAllPosts({bool latest = false}) async {
    try {
      emit(KomunitasLoading());

      final response = await _komunitasUsecase.fetchAllPosts(latest: latest);
      response.fold(
        (error) => emit(KomunitasError(message: '${error.code} ${error.message}')),
        (success) => emit(KomunitasLoaded(postModels: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> fetchAktivitas({
    required User user,
    required String filter,
  }) async {
    try {
      emit(KomunitasLoading());

      final response = await _komunitasUsecase.fetchAktivitas(
        user: user,
        filter: filter,
      );
      response.fold(
        (error) => emit(KomunitasError(message: '${error.code} ${error.message}')),
        (success) => emit(KomunitasLoaded(postModels: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> createPost({required PostModel post}) async {
    try {
      emit(KomunitasLoading());
      final response = await _komunitasUsecase.createPost(post: post);
      response.fold(
        (error) => emit(KomunitasError(message: '${error.code} ${error.message}')),
        (success) {
          emit(CreatePostSuccess());
          fetchAllPosts();
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteAllPosts() async {
    try {
      emit(KomunitasLoading());
      final response = await _komunitasUsecase.deleteAllPosts();
      response.fold(
        (error) => emit(KomunitasError(message: '${error.code} ${error.message}')),
        (success) async => await fetchAllPosts(),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> likePost({required String uid, required PostModel post}) async {
    try {
      final response = await _komunitasUsecase.likePost(
        uid: uid,
        post: post,
      );

      response.fold(
        (error) => emit(KomunitasError(message: '${error.code} ${error.message}')),
        (success) {},
      );
    } catch (_) {
      rethrow;
    }
  }
}
