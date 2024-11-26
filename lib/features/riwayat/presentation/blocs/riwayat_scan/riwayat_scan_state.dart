part of 'riwayat_scan_bloc.dart';

abstract class RiwayatScanState extends Equatable {
  const RiwayatScanState();

  @override
  List<Object?> get props => [];
}

class RiwayatScanInitial extends RiwayatScanState {}

class RiwayatScanLoading extends RiwayatScanState {}

class RiwayatScanSuccess extends RiwayatScanState {
  final RiwayatModel? riwayatModel;
  const RiwayatScanSuccess({required this.riwayatModel});

  @override
  List<Object?> get props => [riwayatModel];
}

class RiwayatScanError extends RiwayatScanState {
  final String message;
  const RiwayatScanError({required this.message});

  @override
  List<Object?> get props => [message];
}
