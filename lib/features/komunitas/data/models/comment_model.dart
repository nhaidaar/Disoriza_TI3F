import '../../../user/data/models/user_model.dart';
import 'post_model.dart';

class CommentModel {
  final String? id;
  final UserModel? commentator;
  final String? value;
  final List<String>? likes;
  final PostModel? idPost;
  final DateTime? date;

  const CommentModel({
    this.id,
    this.commentator,
    this.value,
    this.likes,
    this.idPost,
    this.date,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['\$id'],
      commentator: UserModel.fromMap(map['commentator']),
      value: map['value'],
      likes: (map['likes'] as List<dynamic>?)?.map((like) {
        return like['\$id'].toString();
      }).toList(),
      idPost: PostModel.fromMap(map['id_post']),
      date: DateTime.parse(map['\$createdAt']),
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'commentator': commentator?.id,
      'value': value,
      'id_post': idPost?.id,
      'likes': likes ?? [],
    };
  }

  CommentModel copyWith({
    String? id,
    UserModel? commentator,
    String? value,
    List<String>? likes,
    PostModel? idPost,
    DateTime? date,
  }) {
    return CommentModel(
      id: id ?? this.id,
      commentator: commentator ?? this.commentator,
      value: value ?? this.value,
      likes: likes ?? this.likes,
      idPost: idPost ?? this.idPost,
      date: date ?? this.date,
    );
  }
}
