part of 'komunitas_cubit.dart';

abstract class KomunitasState extends Equatable {
  const KomunitasState();

  @override
  List<Object> get props => [];
}

class KomunitasInitial extends KomunitasState {}

class KomunitasLoading extends KomunitasState {}

class KomunitasLoaded extends KomunitasState {
  final List<PostModel> postModels;
  const KomunitasLoaded({required this.postModels});

  @override
  List<Object> get props => [postModels];
}

class KomunitasError extends KomunitasState {
  final String message;
  const KomunitasError({required this.message});

  @override
  List<Object> get props => [message];
}

class CreatePostSuccess extends KomunitasState {}
