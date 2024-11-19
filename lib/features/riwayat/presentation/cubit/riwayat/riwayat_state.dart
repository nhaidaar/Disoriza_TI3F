part of 'riwayat_cubit.dart';

abstract class RiwayatState extends Equatable {
  const RiwayatState();

  @override
  List<Object> get props => [];
}

class RiwayatInitial extends RiwayatState {}

class RiwayatLoading extends RiwayatState {}

class RiwayatLoaded extends RiwayatState {
  final List<RiwayatModel> riwayatModel;
  const RiwayatLoaded({required this.riwayatModel});

  @override
  List<Object> get props => [riwayatModel];
}

class RiwayatDeleted extends RiwayatState {}

class RiwayatError extends RiwayatState {
  final String message;
  const RiwayatError({required this.message});

  @override
  List<Object> get props => [message];
}
