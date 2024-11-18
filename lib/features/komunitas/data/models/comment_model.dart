import '../../../auth/data/models/user_model.dart';

class CommentModel {
  final int? id;
  final UserModel? idUser;
  final int? idPost;
  final String? content;
  final List<String>? likes;
  final DateTime? date;

  const CommentModel({
    this.id,
    this.idUser,
    this.idPost,
    this.content,
    this.likes,
    this.date,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      idUser: UserModel.fromMap(map['users']),
      idPost: map['id_post'],
      content: map['content'],
      likes: (map['liked_comments'] as List).map((like) {
        return like['id_user'].toString();
      }).toList(),
      date: DateTime.parse(map['created_at']),
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'id_user': idUser?.id,
      'id_post': idPost,
      'content': content,
    };
  }

  CommentModel copyWith({
    int? id,
    UserModel? idUser,
    int? idPost,
    String? content,
    List<String>? likes,
    DateTime? date,
  }) {
    return CommentModel(
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      idPost: idPost ?? this.idPost,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      date: date ?? this.date,
    );
  }
}
