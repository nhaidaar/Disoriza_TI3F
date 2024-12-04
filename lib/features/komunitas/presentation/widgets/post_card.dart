import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_avatar.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/post_model.dart';
import '../blocs/komunitas_comment/komunitas_comment_bloc.dart';
import '../blocs/komunitas_post/komunitas_post_bloc.dart';
import '../pages/detail_post_page.dart';
import 'components/user_details.dart';

class PostCard extends StatefulWidget {
  final UserModel user;
  final PostModel post;
  final bool isAktivitas;
  final bool isBerandaCard;

  const PostCard({
    super.key,
    required this.user,
    required this.post,
    this.isAktivitas = false,
    this.isBerandaCard = false,
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
    isLiked = (widget.post.likes ?? []).contains(widget.user.id);
    isCommented = (widget.post.comments ?? []).contains(widget.user.id);
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
                value: context.read<KomunitasPostBloc>(),
              ),
              BlocProvider.value(
                value: context.read<KomunitasCommentBloc>(),
              ),
            ],
            child: DetailPostPage(user: widget.user, post: widget.post),
          ),
          type: PageTransitionType.rightToLeft,
        ),
      ),
      child: Container(
        margin: widget.isBerandaCard ? const EdgeInsets.symmetric(horizontal: 10) : const EdgeInsets.only(bottom: 8),
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
            UserDetails(
              profilePicture: widget.post.author?.profilePicture,
              name: widget.post.author != null ? widget.post.author!.name.toString() : 'Disoriza User',
              isAdmin: widget.post.author?.isAdmin ?? false,
              date: widget.post.date,
            ),

            const SizedBox(height: 12),

            Text(
              widget.post.title.toString(),
              style: semiboldTS.copyWith(fontSize: 16, color: neutral100),
              maxLines: widget.isBerandaCard ? 1 : 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            Text(
              widget.post.content.toString(),
              style: mediumTS.copyWith(color: neutral90),
              maxLines: widget.isBerandaCard ? 1 : 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // Image (optional)
            if (!widget.isBerandaCard && widget.post.urlImage != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: widget.post.urlImage.toString(),
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
                  (widget.post.likes ?? []).length.toString(),
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
                  (widget.post.comments ?? []).length.toString(),
                  style: mediumTS.copyWith(fontSize: 12, color: neutral80),
                ),

                if ((isLiked || isCommented) && widget.isAktivitas) ...[
                  const Spacer(),
                  CustomAvatar(
                    link: widget.user.profilePicture,
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
      isLiked
          ? (widget.post.likes ?? []).add(widget.user.id.toString())
          : (widget.post.likes ?? []).remove(widget.user.id.toString());
    });

    isLiked
        ? context.read<KomunitasPostBloc>().add(KomunitasLikePost(
              uid: widget.user.id.toString(),
              postId: widget.post.id.toString(),
            ))
        : context.read<KomunitasPostBloc>().add(KomunitasUnlikePost(
              uid: widget.user.id.toString(),
              postId: widget.post.id.toString(),
            ));
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
