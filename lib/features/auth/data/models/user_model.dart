class UserModel {
  final String? id; // Appwrite document ID ($id)
  final String? idUser;
  final String? email;
  final String? name;
  final List<String>? likedPosts; // References to post IDs
  final List<String>? likedComments; // References to comment IDs
  final List<String>? posts; // References to post IDs
  final List<String>? comments; // References to comment IDs
  final String? profilePicture;
  final String? idImage;

  UserModel({
    this.id,
    this.idUser,
    this.email,
    this.name,
    this.likedPosts,
    this.likedComments,
    this.posts,
    this.comments,
    this.profilePicture,
    this.idImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'],
      idUser: map['id_user'],
      email: map['email'],
      name: map['name'],
      likedPosts: List<String>.from(map['liked_post'] ?? []),
      likedComments: List<String>.from(map['liked_comment'] ?? []),
      posts: List<String>.from(map['posts'] ?? []),
      comments: List<String>.from(map['comments'] ?? []),
      profilePicture: map['url_image'],
      idImage: map['id_image'],
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'id_user': idUser,
      'email': email,
      'name': name,
      'liked_posts': likedPosts ?? [],
      'liked_comments': likedComments ?? [],
      'posts': posts ?? [],
      'comments': comments ?? [],
      'url_image': profilePicture,
      'id_image': idImage,
    };
  }

  UserModel copyWith({
    String? id,
    String? idUser,
    String? email,
    String? name,
    List<String>? likedPosts,
    List<String>? likedComments,
    List<String>? posts,
    List<String>? comments,
    String? profilePicture,
    String? idImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      email: email ?? this.email,
      name: name ?? this.name,
      likedPosts: likedPosts ?? this.likedPosts,
      likedComments: likedComments ?? this.likedComments,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      profilePicture: profilePicture ?? this.profilePicture,
      idImage: idImage ?? this.idImage,
    );
  }
}
