part of 'komunitas_search_bloc.dart';

abstract class KomunitasSearchEvent extends Equatable {
  const KomunitasSearchEvent();

  @override
  List<Object> get props => [];
}

class KomunitasSearchPost extends KomunitasSearchEvent {
  final String search;
  const KomunitasSearchPost({required this.search});

  @override
  List<Object> get props => [search];
}
