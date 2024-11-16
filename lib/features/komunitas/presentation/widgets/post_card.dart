import 'package:appwrite/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_avatar.dart';
import '../../../../core/common/custom_dropdown.dart';
import '../../../../core/common/custom_empty_state.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../data/models/post_model.dart';
import '../cubit/comment/comment_cubit.dart';
import '../cubit/komunitas/komunitas_cubit.dart';
import '../pages/post_page.dart';
import 'comment_card.dart';
import 'post_loading_card.dart';

class PostCard extends StatefulWidget {
  final User user;
  final bool fullPost;
  final bool isAktivitas;
  final PostModel postModel;

  const PostCard({
    super.key,
    required this.user,
    required this.postModel,
    this.fullPost = false,
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
    isLiked = (widget.postModel.likes ?? []).contains(widget.user.$id);
    isCommented = (widget.postModel.comments ?? []).contains(widget.user.$id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.fullPost
          ? null
          : () => Navigator.of(context).push(
                PageTransition(
                  child: BlocProvider.value(
                    value: context.read<CommentCubit>(),
                    child: PostPage(user: widget.user, postModel: widget.postModel),
                  ),
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
                CustomAvatar(link: widget.postModel.author!.profilePicture),

                const SizedBox(width: 12),

                // User details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postModel.author != null
                          ? widget.postModel.author!.name.toString()
                          : 'Disoriza User',
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
              maxLines: !widget.fullPost ? 2 : null,
              overflow: !widget.fullPost ? TextOverflow.ellipsis : null,
            ),

            const SizedBox(height: 4),

            Text(
              widget.postModel.content.toString(),
              style: mediumTS.copyWith(color: neutral90),
              maxLines: !widget.fullPost ? 3 : null,
              overflow: !widget.fullPost ? TextOverflow.ellipsis : null,
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
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                      isLiked
                          ? (widget.postModel.likes ?? []).add(widget.user.$id)
                          : (widget.postModel.likes ?? []).remove(widget.user.$id);
                    });

                    context.read<KomunitasCubit>().likePost(
                          uid: widget.user.$id,
                          post: widget.postModel,
                        );
                  },
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

                if ((isLiked || isCommented) && !widget.fullPost && widget.isAktivitas) ...[
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
                    items: const [
                      MapEntry('Terpopuler', false),
                      MapEntry('Terbaru', true),
                    ],
                    initialValue: const MapEntry('Terpopuler', false),
                    onChanged: (filter) async {
                      if (isLatest != filter.value) {
                        isLatest = !isLatest;
                        context.read<CommentCubit>().fetchComments(
                              postId: widget.postModel.id.toString(),
                              latest: isLatest,
                            );
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // List of Komentar
              BlocBuilder<CommentCubit, CommentState>(
                builder: (context, state) {
                  if (state is CommentLoading) {
                    return const PostLoadingCard();
                  }
                  if (state is CommentLoaded) {
                    return state.commentModels.isNotEmpty
                        ? Column(
                            children: state.commentModels.map((comment) {
                              return CommentCard(
                                user: widget.user,
                                commentModel: comment,
                              );
                            }).toList(),
                          )
                        : const Center(child: KomentarEmptyState());
                  }
                  return const Center(child: KomentarEmptyState());
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
