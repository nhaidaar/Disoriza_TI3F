import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/riwayat_model.dart';
import '../../../domain/usecases/riwayat_usecase.dart';

part 'riwayat_scan_event.dart';
part 'riwayat_scan_state.dart';

class RiwayatScanBloc extends Bloc<RiwayatScanEvent, RiwayatScanState> {
  final RiwayatUsecase _riwayatUsecase;

  RiwayatScanBloc(this._riwayatUsecase) : super(RiwayatScanInitial()) {
    on<RiwayatScanDisease>((event, emit) async {
      try {
        emit(RiwayatScanLoading());

        final response = await _riwayatUsecase.scanDisease(
          uid: event.uid,
          image: event.image,
        );
        response.fold(
          (error) => emit(RiwayatScanError(message: error.toString())),
          (success) => emit(RiwayatScanSuccess(riwayatModel: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
  }
}
