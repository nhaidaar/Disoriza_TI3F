part of 'komunitas_comment_bloc.dart';

abstract class KomunitasCommentState extends Equatable {
  const KomunitasCommentState();

  @override
  List<Object> get props => [];
}

class KomunitasCommentInitial extends KomunitasCommentState {}

class KomunitasCommentLoading extends KomunitasCommentState {}

class KomunitasCommentLoaded extends KomunitasCommentState {
  final List<CommentModel> commentModels;
  const KomunitasCommentLoaded({required this.commentModels});

  @override
  List<Object> get props => [commentModels];
}

class KomunitasCommentError extends KomunitasCommentState {
  final String message;
  const KomunitasCommentError({required this.message});

  @override
  List<Object> get props => [message];
}

class KomunitasCommentCreated extends KomunitasCommentState {}

class KomunitasCommentDeleted extends KomunitasCommentState {}
