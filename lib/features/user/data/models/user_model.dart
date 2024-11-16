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
      id: map['\$id'],
      email: map['email'],
      name: map['name'],

      // Take the id of liked_post entity
      likedPosts: (map['liked_post'] as List<dynamic>?)?.map((likedPost) {
        return likedPost['\$id'].toString();
      }).toList(),

      // Take the id_post of liked_comment entity
      likedComments: (map['liked_comment'] as List<dynamic>?)?.where((likedComment) {
        return likedComment is Map<String, dynamic> && likedComment.containsKey('id_post');
      }).map((likedComment) {
        return (likedComment['id_post'] as Map<String, dynamic>)['\$id'].toString();
      }).toList(),

      // Take the id of post entity
      posts: (map['posts'] as List<dynamic>?)?.map((post) {
        return post['\$id'].toString();
      }).toList(),

      // Take the id_post of comments entity
      comments: (map['comments'] as List<dynamic>?)?.where((comment) {
        return comment is Map<String, dynamic> && comment.containsKey('id_post');
      }).map((comment) {
        return (comment['id_post'] as Map<String, dynamic>)['\$id'].toString();
      }).toList(),

      profilePicture: map['url_image'],
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'liked_posts': likedPosts ?? [],
      'liked_comments': likedComments ?? [],
      'posts': posts ?? [],
      'comments': comments ?? [],
      'url_image': profilePicture,
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
