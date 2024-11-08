import '../../../user/data/models/user_model.dart';
import 'post_model.dart';

class CommentModel {
  final String? id;
  final UserModel? idCommentator;
  final String? value;
  final List<String>? likes;
  final PostModel? idPost;
  final int? date;

  const CommentModel({
    this.id,
    this.idCommentator,
    this.value,
    this.likes,
    this.idPost,
    this.date,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['\$id'],
      idCommentator: UserModel.fromMap(map['id_commentator']),
      value: map['value'],
      likes: [],
      idPost: PostModel.fromMap(map['id_post']),
      date: map['date'],
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'id_commentator': idCommentator?.id,
      'value': value,
      'id_post': idPost?.id,
      'likes': likes ?? [],
      'date': date,
    };
  }

  CommentModel copyWith({
    String? id,
    UserModel? idCommentator,
    String? value,
    List<String>? likes,
    PostModel? idPost,
    int? date,
  }) {
    return CommentModel(
      id: id ?? this.id,
      idCommentator: idCommentator ?? this.idCommentator,
      value: value ?? this.value,
      likes: likes ?? this.likes,
      idPost: idPost ?? this.idPost,
      date: date ?? this.date,
    );
  }
}
