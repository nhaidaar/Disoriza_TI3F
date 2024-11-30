part of 'komunitas_search_bloc.dart';

abstract class KomunitasSearchState extends Equatable {
  const KomunitasSearchState();

  @override
  List<Object> get props => [];
}

class KomunitasSearchInitial extends KomunitasSearchState {}

class KomunitasSearchLoading extends KomunitasSearchState {}

class KomunitasSearchLoaded extends KomunitasSearchState {
  final List<PostModel> postModels;
  const KomunitasSearchLoaded({required this.postModels});

  @override
  List<Object> get props => [postModels];
}

class KomunitasSearchError extends KomunitasSearchState {
  final String message;
  const KomunitasSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
