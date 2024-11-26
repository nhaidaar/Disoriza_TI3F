part of 'komunitas_post_bloc.dart';

abstract class KomunitasPostState extends Equatable {
  const KomunitasPostState();

  @override
  List<Object> get props => [];
}

class KomunitasPostInitial extends KomunitasPostState {}

class KomunitasPostLoading extends KomunitasPostState {}

class KomunitasPostLoaded extends KomunitasPostState {
  final List<PostModel> postModels;
  const KomunitasPostLoaded({required this.postModels});

  @override
  List<Object> get props => [postModels];
}

class KomunitasPostError extends KomunitasPostState {
  final String message;
  const KomunitasPostError({required this.message});

  @override
  List<Object> get props => [message];
}

class KomunitasPostCreated extends KomunitasPostState {}

class KomunitasPostDeleted extends KomunitasPostState {}
