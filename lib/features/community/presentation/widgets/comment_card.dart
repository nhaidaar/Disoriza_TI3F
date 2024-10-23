import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/paddings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isLiked = true;
  late int likeCount = 12;

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount--; 
      } else {
        likeCount++; 
      }
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: neutral30),
              borderRadius: const BorderRadius.all(Radius.circular(16))),
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
              const Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s '
                'passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                overflow: TextOverflow.visible,
                style: TextStyle(color: neutral90),
              ),
              const SizedBox(height: small),
              Row(
                children: [
                  GestureDetector(
                    onTap: _toggleLike,
                    child: isLiked
                        ? const Icon(IconsaxPlusBold.heart,
                            color: dangerMain) // Liked state
                        : const Icon(IconsaxPlusLinear.heart), // Unliked state
                  ),
                  const SizedBox(width: 4),
                  Text('$likeCount'), // Dynamic like count
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
