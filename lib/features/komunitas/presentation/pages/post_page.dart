import 'package:appwrite/models.dart';
import 'package:disoriza/features/komunitas/presentation/cubit/comment/comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../user/data/models/user_model.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';
import '../widgets/post_card.dart';

class PostPage extends StatefulWidget {
  final User user;
  final PostModel postModel;
  const PostPage({super.key, required this.postModel, required this.user});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final commentController = TextEditingController();

  @override
  void initState() {
    context.read<CommentCubit>().fetchComments(
          postId: widget.postModel.id.toString(),
        );
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                PostCard(
                  user: widget.user,
                  postModel: widget.postModel,
                  fullPost: true,
                ),
              ],
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
                        idPost: PostModel(id: widget.postModel.id),
                        commentator: UserModel(id: widget.user.$id),
                        value: commentController.text,
                        date: DateTime.now().millisecondsSinceEpoch,
                      );

                      context.read<CommentCubit>().createComment(comment: comment);

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
    );
  }
}
