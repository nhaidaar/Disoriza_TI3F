import 'package:flutter/material.dart';

class ImagePost extends StatelessWidget {
  final String source;
  const ImagePost({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image(
        image: NetworkImage(source),
        height: 288,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
