part of 'komunitas_report_bloc.dart';

abstract class KomunitasReportState extends Equatable {
  const KomunitasReportState();

  @override
  List<Object> get props => [];
}

class KomunitasReportInitial extends KomunitasReportState {}

class KomunitasReportPostReported extends KomunitasReportState {}

class KomunitasReportCommentReported extends KomunitasReportState {}

class KomunitasReportError extends KomunitasReportState {
  final String message;
  const KomunitasReportError({required this.message});

  @override
  List<Object> get props => [message];
}
