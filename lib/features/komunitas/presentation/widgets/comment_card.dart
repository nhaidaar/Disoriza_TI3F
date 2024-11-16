import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_avatar.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../data/models/comment_model.dart';
import '../cubit/comment/comment_cubit.dart';

class CommentCard extends StatefulWidget {
  final User user;
  final CommentModel commentModel;

  const CommentCard({
    super.key,
    required this.user,
    required this.commentModel,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isLiked = false;

  @override
  void initState() {
    isLiked = (widget.commentModel.likes ?? []).contains(widget.user.$id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              CustomAvatar(link: widget.commentModel.commentator!.profilePicture),

              const SizedBox(width: 12),

              // User details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.commentModel.commentator != null
                        ? widget.commentModel.commentator!.name.toString()
                        : 'Disoriza User',
                    style: mediumTS.copyWith(color: neutral100),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeago.format(widget.commentModel.date ?? DateTime.now()),
                    style: mediumTS.copyWith(fontSize: 12, color: neutral60),
                  )
                ],
              )
            ],
          ),

          const SizedBox(height: 8),

          Text(
            widget.commentModel.value.toString(),
            style: mediumTS.copyWith(color: neutral90),
          ),

          const SizedBox(height: 8),

          // Like
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                    isLiked
                        ? (widget.commentModel.likes ?? []).add(widget.user.$id)
                        : (widget.commentModel.likes ?? []).remove(widget.user.$id);
                  });

                  context.read<CommentCubit>().likeComment(
                        uid: widget.user.$id,
                        comment: widget.commentModel,
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
                (widget.commentModel.likes ?? []).length.toString(),
                style: mediumTS.copyWith(fontSize: 12, color: neutral80),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
