class PostModel {
  final String? id; // Appwrite document ID ($id)
  final String? title;
  final String? content;
  final String? urlImage;
  final String? idImage;
  final String? idCreator;
  final List<String>? likes; // References to Users who liked the Post  
  final List<String>? comments; // References to Users who comment the Post  

  PostModel({
    this.id,
    this.title,
    this.content,
    this.urlImage,
    this.idImage,
    this.idCreator,
    this.likes,
    this.comments,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['\$id'],
      title: map['title'],
      content: map['content'],
      urlImage: map['urlImage'],
      idImage: map['idImage'],
      idCreator: map['idCreator'],
      likes: List<String>.from(map['likes'] ?? []),
      comments: List<String>.from(map['comments'] ?? []),
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'url_image': urlImage,
      'id_image': idImage,
      'id_creator': idCreator,
      'likes': likes,
      'comments': comments,
    };
  }

  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    String? urlImage,
    String? idImage,
    String? idCreator,
    List<String>? likes,
    List<String>? comments,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      urlImage: urlImage ?? this.urlImage,
      idImage: idImage ?? this.idImage,
      idCreator: idCreator ?? this.idCreator,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}
