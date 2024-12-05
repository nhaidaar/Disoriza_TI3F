import '../../../auth/data/models/user_model.dart';

class PostModel {
  final int? id;
  final String? title;
  final String? content;
  final String? urlImage;
  final UserModel? author;
  final List<String>? likes;
  final List<String>? comments;
  final List<String>? reports;
  final DateTime? date;

  const PostModel({
    this.id,
    this.title,
    this.content,
    this.urlImage,
    this.author,
    this.likes,
    this.comments,
    this.reports,
    this.date,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      urlImage: map['url_image'],
      author: UserModel.fromMap(map['users']),
      likes: (map['liked_posts'] as List).map((like) {
        return like['id_user'].toString();
      }).toList(),
      comments: (map['comments'] as List).map((comment) {
        return comment['id_user'].toString();
      }).toList(),
      reports: (map['reported_posts'] as List).map((comment) {
        return comment['id_user'].toString();
      }).toList(),
      date: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'url_image': urlImage,
      'id_user': author?.id,
    };
  }

  PostModel copyWith({
    int? id,
    String? title,
    String? content,
    String? urlImage,
    UserModel? author,
    List<String>? likes,
    List<String>? comments,
    List<String>? reports,
    DateTime? date,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      urlImage: urlImage ?? this.urlImage,
      author: author ?? this.author,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      reports: reports ?? this.reports,
      date: date ?? this.date,
    );
  }
}
