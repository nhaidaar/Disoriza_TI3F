import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/riwayat_model.dart';
import '../../../domain/usecases/riwayat_usecase.dart';

part 'disease_state.dart';

class DiseaseCubit extends Cubit<DiseaseState> {
  final RiwayatUsecase _riwayatUsecase;

  DiseaseCubit(this._riwayatUsecase) : super(DiseaseInitial());

  Future<void> scanDisease({
    required String uid,
    required XFile image,
  }) async {
    try {
      emit(DiseaseLoading());

      final response = await _riwayatUsecase.scanDisease(uid: uid, image: image);
      response.fold(
        (error) => emit(DiseaseError(message: error.toString())),
        (success) => emit(DiseaseSuccess(riwayatModel: success)),
      );
    } catch (_) {
      rethrow;
    }
  }
}
