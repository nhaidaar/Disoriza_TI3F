import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_avatar.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../komunitas/data/models/post_model.dart';
import '../../../komunitas/presentation/cubit/comment/comment_cubit.dart';
import '../../../komunitas/presentation/cubit/komunitas/komunitas_cubit.dart';
import '../../../komunitas/presentation/pages/post_page.dart';

class BerandaKomunitasCard extends StatefulWidget {
  final User user;
  final PostModel postModel;
  const BerandaKomunitasCard({
    super.key,
    required this.user,
    required this.postModel,
  });

  @override
  State<BerandaKomunitasCard> createState() => _BerandaKomunitasCardState();
}

class _BerandaKomunitasCardState extends State<BerandaKomunitasCard> {
  bool isLiked = false;

  @override
  void initState() {
    isLiked = (widget.postModel.likes ?? []).contains(widget.user.$id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            child: BlocProvider.value(
              value: context.read<CommentCubit>(),
              child: PostPage(user: widget.user, postModel: widget.postModel),
            ),
            type: PageTransitionType.rightToLeft,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: neutral10,
          border: Border.all(color: neutral30),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // User
            Row(
              children: [
                CustomAvatar(link: widget.postModel.urlImage),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postModel.creator != null
                          ? widget.postModel.creator!.name.toString()
                          : 'Disoriza User',
                      style: mediumTS.copyWith(color: neutral100),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      timeago.format(
                        DateTime.fromMillisecondsSinceEpoch(widget.postModel.date ?? 0),
                      ),
                      style: mediumTS.copyWith(fontSize: 12, color: neutral60),
                    )
                  ],
                )
              ],
            ),

            const SizedBox(height: 12),

            // Post
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.postModel.title.toString(),
                        style: semiboldTS.copyWith(fontSize: 16, color: neutral100),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.postModel.content.toString(),
                        style: mediumTS.copyWith(color: neutral90),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Like and Comment count
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
