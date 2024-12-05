import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/komunitas_usecase.dart';

part 'komunitas_report_event.dart';
part 'komunitas_report_state.dart';

class KomunitasReportBloc extends Bloc<KomunitasReportEvent, KomunitasReportState> {
  final KomunitasUsecase _komunitasUsecase;
  KomunitasReportBloc(this._komunitasUsecase) : super(KomunitasReportInitial()) {
    on<KomunitasReportPost>((event, emit) async {
      try {
        final response = await _komunitasUsecase.reportPost(
          uid: event.uid,
          postId: event.postId,
        );

        response.fold(
          (error) => emit(KomunitasReportError(message: error.toString().split(': ').last)),
          (success) => emit(KomunitasReportPostReported()),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<KomunitasReportComment>((event, emit) async {
      try {
        final response = await _komunitasUsecase.reportComment(
          uid: event.uid,
          commentId: event.commentId,
        );

        response.fold(
          (error) => emit(KomunitasReportError(message: error.toString().split(': ').last)),
          (success) => emit(KomunitasReportCommentReported()),
        );
      } catch (_) {
        rethrow;
      }
    });
  }
}
