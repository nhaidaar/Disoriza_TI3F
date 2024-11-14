import 'package:appwrite/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/riwayat_model.dart';
import '../../domain/usecases/riwayat_usecase.dart';

part 'riwayat_state.dart';

class RiwayatCubit extends Cubit<RiwayatState> {
  final RiwayatUsecase _RiwayatUsecase;

  RiwayatCubit(this._RiwayatUsecase) : super(RiwayatInitial());

  Future<void> fetchAllRiwayat({bool latest = false, required User user,}) async {
    try {
      emit(RiwayatLoading());

      final response = await _RiwayatUsecase.fetchAllRiwayat(latest: latest, user: user);
      response.fold(
        (error) => emit(RiwayatError(message: '${error.code} ${error.message}')),
        (success) => emit(RiwayatLoaded(histModels: success)),
      );
    } catch (_) {
      rethrow;
    }
  }


  // Future<void> deleteRiwayat({required String histId, required User user}) async {
  Future<void> deleteRiwayat({required String histId}) async {
    try {
      emit(RiwayatLoading());

      final response = await _RiwayatUsecase.deleteRiwayat(histId: histId);
      response.fold(
        (error) => emit(RiwayatError(message: '${error.code} ${error.message}')),
        (success) {
          emit(RiwayatDeleted());
          // fetchAllRiwayat(user: user);
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> fetchDisease({required String id_disease}) async {
    try {
      emit(RiwayatLoading());

      final response = await _RiwayatUsecase.fetchDisease(id_disease: id_disease);
      response.fold(
        (error) => emit(RiwayatError(message: '${error.code} ${error.message}')),
        (success) => emit(RiwayatDiseaseLoaded(diseaseModel: success)),
      );
    } catch (_) {
      rethrow;
    }
  }
}
