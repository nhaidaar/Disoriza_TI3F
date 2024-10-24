class PostItemCard  {
  final String author;
  final String timeAgo;
  final String title;
  final String content;
  final int likes;
  final int commands;
  final String imageUrl;

  PostItemCard({
    required this.author,
    required this.timeAgo,
    required this.title,
    required this.content,
    required this.likes,
    required this.commands,
    this.imageUrl = '',
  });
}
