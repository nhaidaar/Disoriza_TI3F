import 'package:disoriza/core/common/paddings.dart';
import 'package:disoriza/features/community/presentation/widgets/image_post.dart';
import 'package:disoriza/features/community/presentation/widgets/like_button.dart';
import 'package:disoriza/features/community/presentation/widgets/user_post_status.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = true;
  bool _isComment = false;
  bool image = false;

  _like() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  void _comment() {
    setState(() {
      _isComment = !_isComment;
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
          const Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s '
            'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: TextStyle(color: neutral90),
          ),
          const SizedBox(height: small),
          const ImagePost(source: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
          const SizedBox(height: small),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Bagian kiri action user
              Row(
                children: [
                  LikeButton(isLiked: _isLiked, like: _like, likeTotal: 12),
                  const SizedBox(
                    width: 16,
                  ),
                  const Row(
                    children: [
                      Icon(IconsaxPlusLinear.message_text_1),
                      SizedBox(
                        width: 4,
                      ),
                      Text('12')
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
