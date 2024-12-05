import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/post_model.dart';
import '../blocs/komunitas_comment/komunitas_comment_bloc.dart';
import '../blocs/komunitas_post/komunitas_post_bloc.dart';
import '../pages/detail_post_page.dart';
import 'components/user_details.dart';

class ReportedPostCard extends StatefulWidget {
  final UserModel user;
  final PostModel post;

  const ReportedPostCard({
    super.key,
    required this.user,
    required this.post,
  });

  @override
  State<ReportedPostCard> createState() => _ReportedPostCardState();
}

class _ReportedPostCardState extends State<ReportedPostCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<KomunitasPostBloc>()),
              BlocProvider.value(value: context.read<KomunitasCommentBloc>()),
            ],
            child: DetailPostPage(user: widget.user, post: widget.post),
          ),
          type: PageTransitionType.rightToLeft,
        ),
      ),
      child: Container(
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            Text(
              widget.post.content.toString(),
              style: mediumTS.copyWith(color: neutral90),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // Image (optional)
            if (widget.post.urlImage != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(imageUrl: widget.post.urlImage.toString()),
              ),
            ],

            const SizedBox(height: 12),

            Text(
              'Dilaporkan oleh ${widget.post.reports?.length} orang',
              style: mediumTS.copyWith(fontSize: 12, color: neutral80),
            )
          ],
        ),
      ),
    );
  }
}
