import 'comment_model.dart';
import 'post_model.dart';

class PostWithCommentModel {
  final CommentModel commentModel;
  final PostModel postModel;

  const PostWithCommentModel({
    required this.commentModel,
    required this.postModel,
  });
}
