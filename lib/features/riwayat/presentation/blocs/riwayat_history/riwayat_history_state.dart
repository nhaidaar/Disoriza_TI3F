part of 'riwayat_history_bloc.dart';

abstract class RiwayatHistoryState extends Equatable {
  const RiwayatHistoryState();

  @override
  List<Object> get props => [];
}

class RiwayatHistoryInitial extends RiwayatHistoryState {}

class RiwayatHistoryLoading extends RiwayatHistoryState {}

class RiwayatHistoryError extends RiwayatHistoryState {
  final String message;
  const RiwayatHistoryError({required this.message});

  @override
  List<Object> get props => [message];
}

class RiwayatHistoryLoaded extends RiwayatHistoryState {
  final List<RiwayatModel> riwayatModel;
  const RiwayatHistoryLoaded({required this.riwayatModel});

  @override
  List<Object> get props => [riwayatModel];
}

class RiwayatHistoryDeleted extends RiwayatHistoryState {}
