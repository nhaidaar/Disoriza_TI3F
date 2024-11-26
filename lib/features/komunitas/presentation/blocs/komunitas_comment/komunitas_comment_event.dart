part of 'komunitas_comment_bloc.dart';

abstract class KomunitasCommentEvent extends Equatable {
  const KomunitasCommentEvent();

  @override
  List<Object?> get props => [];
}

class KomunitasFetchComments extends KomunitasCommentEvent {
  final String postId;
  final bool latest;
  const KomunitasFetchComments({
    required this.postId,
    this.latest = false,
  });

  @override
  List<Object?> get props => [postId, latest];
}

class KomunitasCreateComment extends KomunitasCommentEvent {
  final CommentModel comment;
  const KomunitasCreateComment({required this.comment});

  @override
  List<Object?> get props => [comment];
}

class KomunitasDeleteComment extends KomunitasCommentEvent {
  final String postId;
  final String commentId;
  const KomunitasDeleteComment({
    required this.postId,
    required this.commentId,
  });

  @override
  List<Object?> get props => [postId, commentId];
}

class KomunitasLikeComment extends KomunitasCommentEvent {
  final String uid;
  final String commentId;
  const KomunitasLikeComment({
    required this.uid,
    required this.commentId,
  });

  @override
  List<Object?> get props => [uid, commentId];
}

class KomunitasUnlikeComment extends KomunitasCommentEvent {
  final String uid;
  final String commentId;
  const KomunitasUnlikeComment({
    required this.uid,
    required this.commentId,
  });

  @override
  List<Object?> get props => [uid, commentId];
}
