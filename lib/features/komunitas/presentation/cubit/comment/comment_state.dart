part of 'comment_cubit.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentModel> commentModels;
  const CommentLoaded({required this.commentModels});

  @override
  List<Object> get props => [commentModels];
}

class CommentError extends CommentState {
  final String message;
  const CommentError({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateCommentSuccess extends CommentState {}

class DeleteCommentSuccess extends CommentState {}
