class UserModel {
  final String? id;
  final String? email;
  final String? name;
  final List<String>? likedPosts;
  final List<String>? likedComments;
  final List<String>? posts;
  final List<String>? comments;
  final String? profilePicture;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.likedPosts,
    this.likedComments,
    this.posts,
    this.comments,
    this.profilePicture,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      profilePicture: map['profile_picture'],
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profile_picture': profilePicture,
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
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      likedPosts: likedPosts ?? this.likedPosts,
      likedComments: likedComments ?? this.likedComments,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
