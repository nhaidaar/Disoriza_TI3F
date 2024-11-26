part of 'riwayat_history_bloc.dart';

abstract class RiwayatHistoryEvent extends Equatable {
  const RiwayatHistoryEvent();

  @override
  List<Object?> get props => [];
}

class RiwayatFetchRiwayats extends RiwayatHistoryEvent {
  final String uid;
  final int? max;
  const RiwayatFetchRiwayats({
    required this.uid,
    this.max,
  });

  @override
  List<Object?> get props => [uid, max];
}

class RiwayatDeleteRiwayat extends RiwayatHistoryEvent {
  final String riwayatId;
  const RiwayatDeleteRiwayat({required this.riwayatId});

  @override
  List<Object?> get props => [riwayatId];
}
