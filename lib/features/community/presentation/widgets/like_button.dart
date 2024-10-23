import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final int likeTotal;

  const LikeButton({
    super.key,
    required this.isLiked,
    required this.likeTotal,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likeCount = widget.likeTotal;
  }

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
    return Row(
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
    );
  }
}
