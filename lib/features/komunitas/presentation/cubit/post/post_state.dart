part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> postModels;
  const PostLoaded({required this.postModels});

  @override
  List<Object> get props => [postModels];
}

class PostError extends PostState {
  final String message;
  const PostError({required this.message});

  @override
  List<Object> get props => [message];
}

class CreatePostSuccess extends PostState {}

class DeletePostSuccess extends PostState {}
