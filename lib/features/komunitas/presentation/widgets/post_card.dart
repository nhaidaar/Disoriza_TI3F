import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_dropdown.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../pages/post_page.dart';
import 'comment_card.dart';

class PostCard extends StatefulWidget {
  final bool fullPost;
  final String title;
  final String text;
  final String? image;

  const PostCard({
    super.key,
    required this.title,
    required this.text,
    this.image,
    this.fullPost = false,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.fullPost
          ? null
          : () => Navigator.of(context).push(
                PageTransition(
                  child: const PostPage(),
                  type: PageTransitionType.rightToLeft,
                ),
              ),
      child: Container(
        margin: !widget.fullPost ? const EdgeInsets.only(bottom: 8) : null,
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

            const SizedBox(height: 12),

            Text(
              widget.title,
              style: semiboldTS.copyWith(fontSize: 16, color: neutral100),
              maxLines: !widget.fullPost ? 2 : null,
              overflow: !widget.fullPost ? TextOverflow.ellipsis : null,
            ),

            const SizedBox(height: 4),

            Text(
              widget.text,
              style: mediumTS.copyWith(color: neutral90),
              maxLines: !widget.fullPost ? 3 : null,
              overflow: !widget.fullPost ? TextOverflow.ellipsis : null,
            ),

            const SizedBox(height: 4),

            // Image (optional)
            if (widget.image != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(widget.image.toString()),
              ),
            ],

            const SizedBox(height: 12),

            Row(
              children: [
                // Like
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

                const SizedBox(width: 16),

                // Comment
                const Icon(
                  IconsaxPlusLinear.message_text_1,
                  color: neutral100,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '12',
                  style: mediumTS.copyWith(fontSize: 12, color: neutral80),
                ),

                const Spacer(),

                if (isLiked && !widget.fullPost) ...[
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: neutral30,
                    child: Icon(IconsaxPlusLinear.profile, color: neutral100, size: 12),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    height: 4,
                    width: 4,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: neutral30),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Kamu menyukai postingan ini',
                    style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                  ),
                ]
              ],
            ),

            if (widget.fullPost) ...[
              const SizedBox(height: 12),

              const Divider(thickness: 1, color: neutral30),

              // Komentar title and Filter
              Row(
                children: [
                  Text(
                    'Komentar',
                    style: mediumTS.copyWith(fontSize: 16, color: neutral100),
                  ),
                  const Spacer(),
                  CustomDropdown(
                    items: const ['Terpopuler', 'Terbaru'],
                    initialValue: 'Terpopuler',
                    onChanged: (value) {},
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // List of Komentar
              ...List.generate(3, (index) {
                return const CommentCard(
                  text:
                      'Hmm, tidak bisa begitu saudaraku, mungkin saja kamu tidak mengerti caranya, mungkin saja kamu terlena dengan dunia yang fana ini',
                );
              })
            ]
          ],
        ),
      ),
    );
  }
}
