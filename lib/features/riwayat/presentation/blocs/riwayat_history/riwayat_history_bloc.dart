import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/riwayat_model.dart';
import '../../../domain/usecases/riwayat_usecase.dart';

part 'riwayat_history_event.dart';
part 'riwayat_history_state.dart';

class RiwayatHistoryBloc extends Bloc<RiwayatHistoryEvent, RiwayatHistoryState> {
  final RiwayatUsecase _riwayatUsecase;

  RiwayatHistoryBloc(this._riwayatUsecase) : super(RiwayatHistoryInitial()) {
    on<RiwayatFetchRiwayats>((event, emit) async {
      try {
        emit(RiwayatHistoryLoading());

        final response = await _riwayatUsecase.fetchAllRiwayat(
          uid: event.uid,
          max: event.max,
        );
        response.fold(
          (error) => emit(RiwayatHistoryError(message: error.toString())),
          (success) => emit(RiwayatHistoryLoaded(riwayatModel: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<RiwayatDeleteRiwayat>((event, emit) async {
      try {
        emit(RiwayatHistoryLoading());

        final response = await _riwayatUsecase.deleteRiwayat(riwayatId: event.riwayatId);
        response.fold(
          (error) => emit(RiwayatHistoryError(message: error.toString())),
          (success) => emit(RiwayatHistoryDeleted()),
        );
      } catch (_) {
        rethrow;
      }
    });
  }
}
