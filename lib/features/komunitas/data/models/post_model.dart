import '../../../user/data/models/user_model.dart';

class PostModel {
  final String? id;
  final String? title;
  final String? content;
  final String? urlImage;
  final UserModel? author;
  final List<String>? likes;
  final List<String>? comments;
  final int? date;

  const PostModel({
    this.id,
    this.title,
    this.content,
    this.urlImage,
    this.author,
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
      author: UserModel.fromMap(map['author']),
      likes: (map['likes'] as List<dynamic>?)?.map((like) {
        return like['\$id'].toString();
      }).toList(),
      comments: (map['comments'] as List<dynamic>?)?.map((like) {
        return like['\$id'].toString();
      }).toList(),
      date: map['date'],
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'url_image': urlImage,
      'author': author?.id,
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
    UserModel? author,
    List<String>? likes,
    List<String>? comments,
    int? date,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      urlImage: urlImage ?? this.urlImage,
      author: author ?? this.author,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      date: date ?? this.date,
    );
  }
}
