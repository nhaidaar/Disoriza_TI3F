import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_avatar.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../data/models/post_model.dart';
import '../cubit/comment/comment_cubit.dart';
import '../cubit/post/post_cubit.dart';
import '../pages/detail_post_page.dart';

class PostCard extends StatefulWidget {
  final String uid;
  final bool isAktivitas;
  final PostModel postModel;

  const PostCard({
    super.key,
    required this.uid,
    required this.postModel,
    this.isAktivitas = false,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  bool isCommented = false;
  bool isLatest = false;

  @override
  void initState() {
    isLiked = (widget.postModel.likes ?? []).contains(widget.uid);
    isCommented = (widget.postModel.comments ?? []).contains(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: context.read<CommentCubit>(),
              ),
              BlocProvider.value(
                value: context.read<PostCubit>(),
              ),
            ],
            child: DetailPostPage(uid: widget.uid, postModel: widget.postModel),
          ),
          type: PageTransitionType.rightToLeft,
        ),
      ),
      child: Container(
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
                CustomAvatar(link: widget.postModel.author!.profilePicture),

                const SizedBox(width: 12),

                // User details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postModel.author != null ? widget.postModel.author!.name.toString() : 'Disoriza User',
                      style: mediumTS.copyWith(color: neutral100),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      timeago.format(widget.postModel.date ?? DateTime.now()),
                      style: mediumTS.copyWith(fontSize: 12, color: neutral60),
                    )
                  ],
                )
              ],
            ),

            const SizedBox(height: 12),

            Text(
              widget.postModel.title.toString(),
              style: semiboldTS.copyWith(fontSize: 16, color: neutral100),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            Text(
              widget.postModel.content.toString(),
              style: mediumTS.copyWith(color: neutral90),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // Image (optional)
            if (widget.postModel.urlImage != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: widget.postModel.urlImage.toString(),
                ),
              ),
            ],

            const SizedBox(height: 12),

            Row(
              children: [
                // Like
                GestureDetector(
                  onTap: () => handleLikePost(context),
                  child: Icon(
                    isLiked ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
                    color: isLiked ? dangerMain : neutral100,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  (widget.postModel.likes ?? []).length.toString(),
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
                  (widget.postModel.comments ?? []).length.toString(),
                  style: mediumTS.copyWith(fontSize: 12, color: neutral80),
                ),

                if ((isLiked || isCommented) && widget.isAktivitas) ...[
                  const Spacer(),
                  CustomAvatar(
                    link: widget.postModel.author!.profilePicture,
                    radius: 10,
                  ),
                  const SizedBox(width: 4),
                  const CircleAvatar(
                    radius: 2,
                    backgroundColor: neutral30,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Kamu ${isCommented ? 'mengomentari' : 'menyukai'} postingan ini',
                    style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleLikePost(BuildContext context) {
    setState(() {
      isLiked = !isLiked;
      isLiked ? (widget.postModel.likes ?? []).add(widget.uid) : (widget.postModel.likes ?? []).remove(widget.uid);
    });

    isLiked
        ? context.read<PostCubit>().likePost(
              uid: widget.uid,
              postId: widget.postModel.id.toString(),
            )
        : context.read<PostCubit>().unlikePost(
              uid: widget.uid,
              postId: widget.postModel.id.toString(),
            );
  }
}

class PostLoadingCard extends StatelessWidget {
  const PostLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) {
          return CardLoading(
            height: 170,
            margin: const EdgeInsets.only(bottom: 8),
            borderRadius: BorderRadius.circular(16),
          );
        },
      ),
    );
  }
}
