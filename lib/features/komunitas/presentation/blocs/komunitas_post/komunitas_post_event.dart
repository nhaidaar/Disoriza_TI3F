part of 'komunitas_post_bloc.dart';

abstract class KomunitasPostEvent extends Equatable {
  const KomunitasPostEvent();

  @override
  List<Object?> get props => [];
}

class KomunitasFetchAllPosts extends KomunitasPostEvent {
  final bool latest;
  final int? max;
  const KomunitasFetchAllPosts({
    this.latest = false,
    this.max,
  });

  @override
  List<Object?> get props => [latest, max];
}

class KomunitasFetchReportedPosts extends KomunitasPostEvent {}

class KomunitasFetchReportedComments extends KomunitasPostEvent {}

class KomunitasFetchAktivitas extends KomunitasPostEvent {
  final String uid;
  final String filter;
  const KomunitasFetchAktivitas({
    required this.uid,
    required this.filter,
  });

  @override
  List<Object?> get props => [uid, filter];
}

class KomunitasCreatePost extends KomunitasPostEvent {
  final String title;
  final String description;
  final String uid;
  final Uint8List? image;
  const KomunitasCreatePost({
    required this.title,
    required this.description,
    required this.uid,
    this.image,
  });

  @override
  List<Object?> get props => [title, description, uid, image];
}

class KomunitasDeletePost extends KomunitasPostEvent {
  final String postId;
  const KomunitasDeletePost({required this.postId});

  @override
  List<Object?> get props => [postId];
}

class KomunitasLikePost extends KomunitasPostEvent {
  final String uid;
  final String postId;
  const KomunitasLikePost({
    required this.uid,
    required this.postId,
  });

  @override
  List<Object?> get props => [uid, postId];
}

class KomunitasUnlikePost extends KomunitasPostEvent {
  final String uid;
  final String postId;
  const KomunitasUnlikePost({
    required this.uid,
    required this.postId,
  });

  @override
  List<Object?> get props => [uid, postId];
}
