import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/riwayat_model.dart';
import '../../../domain/usecases/riwayat_usecase.dart';

part 'riwayat_state.dart';

class RiwayatCubit extends Cubit<RiwayatState> {
  final RiwayatUsecase _riwayatUsecase;

  RiwayatCubit(this._riwayatUsecase) : super(RiwayatInitial());

  Future<void> fetchAllRiwayat({
    required String uid,
    int? max,
  }) async {
    try {
      emit(RiwayatLoading());

      final response = await _riwayatUsecase.fetchAllRiwayat(uid: uid, max: max);
      response.fold(
        (error) => emit(RiwayatError(message: error.toString())),
        (success) => emit(RiwayatLoaded(riwayatModel: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteRiwayat({required String riwayatId}) async {
    try {
      emit(RiwayatLoading());

      final response = await _riwayatUsecase.deleteRiwayat(riwayatId: riwayatId);
      response.fold(
        (error) => emit(RiwayatError(message: error.toString())),
        (success) => emit(RiwayatDeleted()),
      );
    } catch (_) {
      rethrow;
    }
  }
}
