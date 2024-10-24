import 'package:disoriza/core/common/paddings.dart';
import 'package:disoriza/core/common/fontstyles.dart';
import 'package:disoriza/features/community/presentation/widgets/like_button.dart';
import 'package:disoriza/features/community/presentation/widgets/user_post_status.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:disoriza/features/community/presentation/model/discussion_item.dart';

import '../../../../core/common/colors.dart';

class PostCard extends StatefulWidget {
  final PostItemCard postcard;
  final showText;

  const PostCard({Key? key, required this.postcard, required this.showText})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = false;
  bool _isComment = false;
  bool _showText = false;
  bool image = false;

  int totalLikes = 0;
  int totalcomment = 0;

  @override
  void initState() {
    super.initState();
    totalLikes = widget.postcard.likes;
    _showText = widget.showText;
  }

  _like() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        totalLikes++;
      } else {
        totalLikes--;
      }
    });
    print('Liked: $_isLiked, Total Likes: $totalLikes');
  }

  void _comment() {
    setState(() {
      _isComment = !_isComment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        color: neutral10,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: neutral10,
                    child: Icon(IconsaxPlusLinear.profile, color: neutral100),
                  ),
                  SizedBox(
                    width: small,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.postcard.author),
                      Text(
                        widget.postcard.timeAgo,
                        style: semiboldTS.copyWith(fontSize: small, color: neutral60),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                widget.postcard.title,
                style: boldTS.copyWith(fontSize: 16.0, color: neutral100),
              ),
              const SizedBox(height: small),
              Text(
                widget.postcard.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: TextStyle(color: neutral90),
              ),
              const SizedBox(height: small),
              // Image (optional)
              if (widget.postcard.imageUrl.isNotEmpty) ...[
                const SizedBox(height: small),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.postcard.imageUrl,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 100,
                      color: Colors.grey[200],
                      child: Center(child: Text("Gagal memuat gambar")),
                    ),
                  ), // Gambar jika ada
                ),
              ],
              const SizedBox(height: small),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bagian kiri action user
                  Row(
                    children: [
                      LikeButton(
                          isLiked: _isLiked,
                          like: _like,
                          likeTotal: totalLikes),
                      const SizedBox(
                        width: medium,
                      ),
                      Row(
                        children: [
                          Icon(IconsaxPlusLinear.message_text_1),
                          SizedBox(
                            width: 4,
                          ),
                          Text('${widget.postcard.commands}'),
                        ],
                      ),
                    ],
                  ),

                  // Bagian kanan (suka/comment atau tidak)
                  UserPostStatus(
                    isLiked: _isLiked,
                    isComment: _isComment,
                    showText: _showText,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
