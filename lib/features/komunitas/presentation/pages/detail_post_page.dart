import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_avatar.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_dropdown.dart';
import '../../../../core/common/custom_empty_state.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';
import '../blocs/komunitas_comment/komunitas_comment_bloc.dart';
import '../blocs/komunitas_post/komunitas_post_bloc.dart';
import '../widgets/comment_card.dart';
import '../widgets/post_card.dart';

class DetailPostPage extends StatefulWidget {
  final String uid;
  final PostModel postModel;
  const DetailPostPage({
    super.key,
    required this.uid,
    required this.postModel,
  });

  @override
  State<DetailPostPage> createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  final commentController = TextEditingController();
  bool isLiked = false;
  bool isLatest = false;

  @override
  void initState() {
    isLiked = (widget.postModel.likes ?? []).contains(widget.uid);
    fetchComments(context);
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void fetchComments(BuildContext context) {
    context.read<KomunitasCommentBloc>().add(KomunitasFetchComments(
          postId: widget.postModel.id.toString(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final postBloc = context.read<KomunitasPostBloc>();

    return MultiBlocListener(
      listeners: [
        BlocListener<KomunitasPostBloc, KomunitasPostState>(
          listener: (context, state) {
            if (state is KomunitasPostDeleted) {
              Navigator.of(context).pop(); // Pop the confirmation popup
              Navigator.of(context).pop(); // Pop the detail post page
              showSnackbar(context, message: 'Postingan berhasil dihapus!');
            }
          },
        ),
        BlocListener<KomunitasCommentBloc, KomunitasCommentState>(
          listener: (context, state) {
            if (state is KomunitasCommentDeleted) {
              Navigator.of(context).pop(); // Pop the confirmation popup
              showSnackbar(context, message: 'Komentar berhasil dihapus!');
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: neutral10,
          surfaceTintColor: neutral10,
          shape: const Border(
            bottom: BorderSide(color: neutral30),
          ),

          // Back Button
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(IconsaxPlusLinear.arrow_left),
          ),

          title: Text(
            'Detail diskusi',
            style: mediumTS.copyWith(fontSize: 16, color: neutral100),
          ),
          centerTitle: true,

          actions: [
            widget.postModel.author!.id == widget.uid
                ? IconButton(
                    onPressed: () => handleDeletePost(context, postBloc),
                    icon: const Icon(IconsaxPlusLinear.trash, color: dangerMain),
                  )
                : Container(),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            fetchComments(context);
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
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
                        ),

                        const SizedBox(height: 4),

                        Text(
                          widget.postModel.content.toString(),
                          style: mediumTS.copyWith(color: neutral90),
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
                          ],
                        ),

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
                                  context.read<KomunitasCommentBloc>().add(KomunitasFetchComments(
                                        postId: widget.postModel.id.toString(),
                                        latest: isLatest,
                                      ));
                                }
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // List of Komentar
                        BlocBuilder<KomunitasCommentBloc, KomunitasCommentState>(
                          builder: (context, state) {
                            if (state is KomunitasCommentLoading) {
                              return const PostLoadingCard();
                            } else if (state is KomunitasCommentLoaded) {
                              return state.commentModels.isNotEmpty
                                  ? Column(
                                      children: state.commentModels.map((comment) {
                                        return CommentCard(
                                          uid: widget.uid,
                                          commentModel: comment,
                                        );
                                      }).toList(),
                                    )
                                  : const Center(child: KomentarEmptyState());
                            }
                            return const Center(child: KomentarEmptyState());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  border: Border.symmetric(horizontal: BorderSide(color: neutral30)),
                  color: neutral10,
                ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    CustomFormField(
                      controller: commentController,
                      backgroundColor: backgroundCanvas,
                      hint: 'Berikan komentar',
                    ),
                    IconButton(
                      onPressed: () {
                        if (commentController.text.isNotEmpty) {
                          final comment = CommentModel(
                            idPost: widget.postModel.id,
                            idUser: UserModel(id: widget.uid),
                            content: commentController.text,
                          );

                          context.read<KomunitasCommentBloc>().add(KomunitasCreateComment(comment: comment));
                          commentController.clear();
                        }
                      },
                      icon: const Icon(IconsaxPlusLinear.send_1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleDeletePost(BuildContext context, KomunitasPostBloc postBloc) {
    return showDialog(
      context: context,
      builder: (context) => CustomPopup(
        icon: IconsaxPlusLinear.trash,
        iconColor: dangerMain,
        title: 'Ingin menghapus diskusi ini?',
        subtitle: 'Setelah dihapus, data tidak dapat diurungkan.',
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  backgroundColor: dangerMain,
                  pressedColor: dangerPressed,
                  onTap: () => postBloc.add(KomunitasDeletePost(postId: widget.postModel.id.toString())),
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

  void handleLikePost(BuildContext context) {
    setState(() {
      isLiked = !isLiked;
      isLiked ? (widget.postModel.likes ?? []).add(widget.uid) : (widget.postModel.likes ?? []).remove(widget.uid);
    });

    isLiked
        ? context.read<KomunitasPostBloc>().add(KomunitasLikePost(
              uid: widget.uid,
              postId: widget.postModel.id.toString(),
            ))
        : context.read<KomunitasPostBloc>().add(KomunitasUnlikePost(
              uid: widget.uid,
              postId: widget.postModel.id.toString(),
            ));
  }
}
