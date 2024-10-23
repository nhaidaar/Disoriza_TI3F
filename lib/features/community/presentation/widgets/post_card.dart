import 'package:disoriza/core/common/paddings.dart';
import 'package:disoriza/features/community/presentation/widgets/image_post.dart';
import 'package:disoriza/features/community/presentation/widgets/like_button.dart';
import 'package:disoriza/features/community/presentation/widgets/user_post_status.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';

class PostCard extends StatefulWidget {
  final bool isDetailDiscussion;

  const PostCard({super.key, required this.isDetailDiscussion});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = true;
  bool _isComment = false;
  bool image = false;
  late int likeCount = 12;

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        likeCount--;
      } else {
        likeCount++;
      }
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: neutral10,
                child: Icon(IconsaxPlusLinear.profile, color: neutral100),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ihza Nurkhafidh'),
                  Text(
                    '12 Hours Ago',
                    style: TextStyle(fontSize: 12, color: neutral60),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: small),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s '
            'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a .'
            'type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining'
            ' essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum '
            'passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
            overflow: widget.isDetailDiscussion
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            maxLines: widget.isDetailDiscussion ? null : 4,
            style: const TextStyle(color: neutral90),
          ),
          const SizedBox(height: small),
          const ImagePost(
              source:
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
          const SizedBox(height: small),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Bagian kiri action user
              Row(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _toggleLike,
                        child: _isLiked
                            ? const Icon(IconsaxPlusBold.heart,
                                color: dangerMain) // Liked state
                            : const Icon(
                                IconsaxPlusLinear.heart), // Unliked state
                      ),
                      const SizedBox(width: 4),
                      Text('$likeCount'), // Dynamic like count
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Row(
                    children: [
                      Icon(IconsaxPlusLinear.message_text_1),
                      SizedBox(
                        width: 4,
                      ),
                      Text('12'), // Dynamic like count
                    ],
                  ),
                ],
              ),

              // Bagian kanan (suka/comment atau tidak)
              UserPostStatus(isLiked: _isLiked, isComment: _isComment)
            ],
          ),
        ],
      ),
    );
  }
}
