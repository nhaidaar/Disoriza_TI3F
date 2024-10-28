import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';
import '../pages/create_post_page.dart';

class CreatePostButton extends StatelessWidget {
  const CreatePostButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: neutral10,
        border: Border.symmetric(
          horizontal: BorderSide(color: neutral40),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              child: const CreatePostPage(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundCanvas,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Greeting Message
              Text(
                'Apa yang ingin kamu tanya atau bagikan?',
                style: mediumTS.copyWith(color: neutral70),
              ),

              // Icon Create Content
              const Icon(IconsaxPlusLinear.edit)
            ],
          ),
        ),
      ),
    );
  }
}
