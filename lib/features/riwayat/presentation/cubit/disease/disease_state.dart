part of 'disease_cubit.dart';

abstract class DiseaseState extends Equatable {
  const DiseaseState();

  @override
  List<Object?> get props => [];
}

class DiseaseInitial extends DiseaseState {}

class DiseaseLoading extends DiseaseState {}

class DiseaseSuccess extends DiseaseState {
  final RiwayatModel? riwayatModel;
  const DiseaseSuccess({required this.riwayatModel});

  @override
  List<Object?> get props => [riwayatModel];
}

class DiseaseError extends DiseaseState {
  final String message;
  const DiseaseError({required this.message});

  @override
  List<Object> get props => [message];
}
