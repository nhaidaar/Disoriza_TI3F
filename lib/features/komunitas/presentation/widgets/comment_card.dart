import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';

class CommentCard extends StatefulWidget {
  final String text;

  const CommentCard({super.key, required this.text});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: defaultSmoothRadius,
        border: Border.all(color: neutral30),
        color: neutral10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              const CircleAvatar(
                radius: 20,
                backgroundColor: neutral10,
                child: Icon(IconsaxPlusLinear.profile, color: neutral100),
              ),

              const SizedBox(width: 12),

              // User details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Wahyu Utami', style: mediumTS.copyWith(color: neutral100)),
                  const SizedBox(height: 4),
                  Text(
                    '12 hours ago',
                    style: mediumTS.copyWith(fontSize: 12, color: neutral60),
                  )
                ],
              )
            ],
          ),

          const SizedBox(height: 8),

          Text(
            widget.text,
            style: mediumTS.copyWith(color: neutral90),
          ),

          const SizedBox(height: 8),

          // Like
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => isLiked = !isLiked);
                },
                child: Icon(
                  isLiked ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
                  color: isLiked ? dangerMain : neutral100,
                  size: 20,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '12',
                style: mediumTS.copyWith(fontSize: 12, color: neutral80),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
