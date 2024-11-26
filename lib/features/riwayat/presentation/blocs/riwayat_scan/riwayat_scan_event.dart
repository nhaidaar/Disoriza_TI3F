part of 'riwayat_scan_bloc.dart';

abstract class RiwayatScanEvent extends Equatable {
  const RiwayatScanEvent();

  @override
  List<Object> get props => [];
}

class RiwayatScanDisease extends RiwayatScanEvent {
  final String uid;
  final XFile image;
  const RiwayatScanDisease({
    required this.uid,
    required this.image,
  });

  @override
  List<Object> get props => [uid, image];
}
