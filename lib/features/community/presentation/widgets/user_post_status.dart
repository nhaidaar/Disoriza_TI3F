import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';

class UserPostStatus extends StatelessWidget {
  final bool isLiked;
  final bool isComment;
  final bool showText;

  const UserPostStatus(
      {super.key, required this.isLiked, required this.isComment, required this.showText});

  @override
  Widget build(BuildContext context) {
    if (!showText) {
      return const SizedBox(); // Tidak menampilkan apa pun
    }
    
    return Row(
      children: [
        isLiked || isComment
            ? Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: backgroundCanvas,
                    child: Icon(
                      IconsaxPlusLinear.profile,
                      color: neutral100,
                      size: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const CircleAvatar(
                    radius: 4,
                    backgroundColor: neutral40,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Kamu ${isLiked ? 'menyukai' : isComment ? 'mengomentari' : ''} postingan ini',
                    style: const TextStyle(fontSize: 12, color: neutral70),
                  )
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
