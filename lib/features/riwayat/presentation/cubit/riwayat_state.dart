part of 'riwayat_cubit.dart';

abstract class RiwayatState extends Equatable {
  const RiwayatState();

  @override
  List<Object> get props => [];
}

class RiwayatInitial extends RiwayatState {}

class RiwayatLoading extends RiwayatState{}

class RiwayatLoaded extends RiwayatState {
  final List<RiwayatModel> histModels;
  const RiwayatLoaded({required this.histModels});

  @override
  List<Object> get props => [histModels];
}

class RiwayatDiseaseLoaded extends RiwayatState {
  final RiwayatModel diseaseModel;

  const RiwayatDiseaseLoaded({required this.diseaseModel});

  @override
  List<Object> get props => [diseaseModel];
}

class RiwayatDeleted extends RiwayatState {}

class RiwayatError extends RiwayatState {
  final String message;
  const RiwayatError({required this.message});

  @override
  List<Object> get props => [message];
}

class CreatePostSuccess extends RiwayatState {}

