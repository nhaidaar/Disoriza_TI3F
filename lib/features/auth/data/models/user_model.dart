class UserModel {
  final String? id; // Appwrite document ID ($id)
  final String? email;
  final String? name;
  final List<String>? likedPosts; // References to post IDs
  final List<String>? likedComments; // References to comment IDs
  final List<String>? posts; // References to post IDs
  final List<String>? comments; // References to comment IDs
  final List<String>? histories; // References to detail_history IDs
  final String? profilePicture;
  final String? idImage;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.likedPosts,
    this.likedComments,
    this.posts,
    this.comments,
    this.histories,
    this.profilePicture,
    this.idImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'],
      email: map['email'],
      name: map['name'],
      likedPosts: List<String>.from(map['liked_post'] ?? []),
      likedComments: List<String>.from(map['liked_comment'] ?? []),
      posts: List<String>.from(map['posts'] ?? []),
      comments: List<String>.from(map['comments'] ?? []),
      histories: List<String>.from(map['histories'] ?? []),
      profilePicture: map['url_image'],
      idImage: map['id_image'],
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'liked_post': likedPosts ?? [],
      'liked_comment': likedComments ?? [],
      'posts': posts ?? [],
      'comments': comments ?? [],
      'histories': histories ?? [],
      'url_image': profilePicture,
      'id_image': idImage,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    List<String>? likedPosts,
    List<String>? likedComments,
    List<String>? posts,
    List<String>? comments,
    List<String>? histories,
    String? profilePicture,
    String? idImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      likedPosts: likedPosts ?? this.likedPosts,
      likedComments: likedComments ?? this.likedComments,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      histories: histories ?? this.histories,
      profilePicture: profilePicture ?? this.profilePicture,
      idImage: idImage ?? this.idImage,
    );
  }
}
