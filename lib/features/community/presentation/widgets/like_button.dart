import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';

// ignore: must_be_immutable
class LikeButton extends StatefulWidget {
  final bool isLiked;
  void Function()? like;
  final int likeTotal;

  LikeButton(
      {super.key,
      required this.isLiked,
      required this.like,
      required this.likeTotal});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      GestureDetector(
          onTap: widget.like,
          child: widget.isLiked
              ? const Icon(
                  IconsaxPlusBold.heart,
                  color:dangerMain
                )
              : const Icon(
                  IconsaxPlusLinear.heart,
                )),
      const SizedBox(
        width: 4,
      ),
      const Text('12')
    ]);
  }
}
