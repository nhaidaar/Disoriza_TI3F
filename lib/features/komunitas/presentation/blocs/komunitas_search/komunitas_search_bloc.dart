import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/post_model.dart';
import '../../../domain/usecases/komunitas_usecase.dart';

part 'komunitas_search_event.dart';
part 'komunitas_search_state.dart';

class KomunitasSearchBloc extends Bloc<KomunitasSearchEvent, KomunitasSearchState> {
  final KomunitasUsecase _komunitasUsecase;
  KomunitasSearchBloc(this._komunitasUsecase) : super(KomunitasSearchInitial()) {
    on<KomunitasSearchPost>((event, emit) async {
      try {
        emit(KomunitasSearchLoading());

        final response = await _komunitasUsecase.searchPost(search: event.search);
        response.fold(
          (error) => emit(KomunitasSearchError(message: error.toString())),
          (success) => emit(KomunitasSearchLoaded(postModels: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
  }
}
