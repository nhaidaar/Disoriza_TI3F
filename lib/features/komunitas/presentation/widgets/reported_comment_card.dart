import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';
import '../blocs/komunitas_comment/komunitas_comment_bloc.dart';
import '../blocs/komunitas_post/komunitas_post_bloc.dart';
import '../pages/detail_post_page.dart';
import 'components/user_details.dart';

class ReportedCommentCard extends StatefulWidget {
  final UserModel user;
  final CommentModel comment;
  final PostModel post;

  const ReportedCommentCard({
    super.key,
    required this.user,
    required this.comment,
    required this.post,
  });

  @override
  State<ReportedCommentCard> createState() => _ReportedCommentCardState();
}

class _ReportedCommentCardState extends State<ReportedCommentCard> {
  @override
  Widget build(BuildContext context) {
    final commentBloc = context.read<KomunitasCommentBloc>();
    final postBloc = context.read<KomunitasPostBloc>();

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
          UserDetails(
            name: widget.comment.idUser != null ? widget.comment.idUser!.name.toString() : 'Disoriza User',
            profilePicture: widget.comment.idUser?.profilePicture,
            date: widget.comment.date,
            isAdmin: widget.comment.idUser?.isAdmin ?? false,
          ),
          const SizedBox(height: 8),
          Text(
            widget.comment.content.toString(),
            style: mediumTS.copyWith(color: neutral90),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Dilaporkan oleh ${widget.comment.reports?.length} orang',
                style: mediumTS.copyWith(fontSize: 12, color: neutral80),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: CircleAvatar(radius: 2, backgroundColor: Color(0xFFD9D9D9)),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(PageTransition(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: commentBloc),
                      BlocProvider.value(value: postBloc),
                    ],
                    child: DetailPostPage(user: widget.user, post: widget.post),
                  ),
                  type: PageTransitionType.rightToLeft,
                )),
                child: Text(
                  'Lihat di postingan',
                  style: mediumTS.copyWith(fontSize: 12, color: accentOrangeMain),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> handleDeleteComment(BuildContext context, KomunitasCommentBloc commentBloc) {
    return showDialog(
      context: context,
      builder: (context) => CustomPopup(
        icon: IconsaxPlusLinear.trash,
        iconColor: dangerMain,
        title: 'Ingin menghapus komentar ini?',
        subtitle: 'Setelah dihapus, data tidak dapat diurungkan.',
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  backgroundColor: dangerMain,
                  pressedColor: dangerPressed,
                  onTap: () => commentBloc.add(KomunitasDeleteComment(
                    postId: widget.comment.idPost.toString(),
                    commentId: widget.comment.id.toString(),
                  )),
                  text: 'Ya, hapus',
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: CustomButton(
                  backgroundColor: neutral10,
                  pressedColor: neutral50,
                  onTap: () => Navigator.of(context).pop(),
                  text: 'Batal',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
