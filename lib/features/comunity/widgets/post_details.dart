import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                  radius: 20,
                  backgroundColor: neutral10,
                  child: Icon(IconsaxPlusLinear.profile, color: neutral100),
                ),

                const SizedBox(width: 8),
            ],
          )
        ],
      ),
    );
  }
}