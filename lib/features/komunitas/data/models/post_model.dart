import '../../../user/data/models/user_model.dart';

class PostModel {
  final String? id;
  final String? title;
  final String? content;
  final String? urlImage;
  final UserModel? author;
  final List<String>? likes;
  final List<String>? comments;
  final DateTime? date;

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

      // Take the uid of commentator in comments
      comments: (map['comments'] as List<dynamic>?)?.where((comment) {
        return comment is Map<String, dynamic> && comment.containsKey('commentator');
      }).map((comment) {
        return (comment['commentator'] as Map<String, dynamic>)['\$id'].toString();
      }).toList(),

      date: DateTime.parse(map['\$createdAt']),
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
      date: date ?? this.date,
    );
  }
}
