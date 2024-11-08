import '../../../user/data/models/user_model.dart';

class PostModel {
  final String? id;
  final String? title;
  final String? content;
  final String? urlImage;
  final UserModel? creator;
  final List<String>? likes;
  final List<String>? comments;
  final int? date;

  const PostModel({
    this.id,
    this.title,
    this.content,
    this.urlImage,
    this.creator,
    this.likes,
    this.comments,
    this.date,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['\$id'],
      title: map['title'],
      content: map['content'],
      urlImage: map['url_image'],
      creator: UserModel.fromMap(map['id_creator']),
      likes: [],
      comments: [],
      date: map['date'],
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'url_image': urlImage,
      'id_creator': creator?.id,
      'likes': likes ?? [],
      'comments': comments ?? [],
      'date': date,
    };
  }

  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    String? urlImage,
    UserModel? creator,
    List<String>? likes,
    List<String>? comments,
    int? date,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      urlImage: urlImage ?? this.urlImage,
      creator: creator ?? this.creator,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      date: date ?? this.date,
    );
  }
}
