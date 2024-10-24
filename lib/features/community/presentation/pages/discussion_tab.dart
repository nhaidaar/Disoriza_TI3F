import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/paddings.dart';
import 'package:disoriza/features/community/presentation/widgets/no_activity_layout.dart';
import 'package:page_transition/page_transition.dart';
import 'package:disoriza/core/common/fontstyles.dart';
import 'package:disoriza/features/community/presentation/model/discussion_item.dart';
import 'package:disoriza/features/community/presentation/widgets/post_card.dart';
import 'package:disoriza/features/community/presentation/pages/create_post.dart';

import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class DiscussionTab extends StatelessWidget {
  const DiscussionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PostItemCard> PItems = [
      PostItemCard(
        author: 'Wahyu Utami',
        timeAgo: '12 hours ago',
        title: 'Cara mendapatkan pestisida',
        content:
            'Hawar daun bakteri adalah penyakit yang disebabkan oleh bakteri Xanthomonas oryzae...',
        likes: 12,
        commands: 12,
        imageUrl: '',
      ),
      PostItemCard(
        author: 'Dhiyun',
        timeAgo: '6 hours ago',
        title: 'Cara mendapatkan pestisida',
        content:
            'Hawar daun bakteri adalah penyakit yang disebabkan oleh bakteri Xanthomonas oryzae...',
        likes: 12,
        commands: 12,
        imageUrl: 'assets/images/main.jpg',
      ),
      PostItemCard(
        author: 'Dhiyun',
        timeAgo: '6 hours ago',
        title: 'Cara mendapatkan pestisida',
        content:
            'Hawar daun bakteri adalah penyakit yang disebabkan oleh bakteri Xanthomonas oryzae...',
        likes: 12,
        commands: 12,
        imageUrl: 'test',
      ),
    ];

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: SizedBox(height: xSmall),
          ),
          SliverAppBar(
            floating: true,
            snap: true,
            toolbarHeight: 70,
            backgroundColor: neutral10,
            title: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: xMedium, vertical: xSmall),
              decoration: BoxDecoration(
                color: backgroundCanvas,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: CreatePost(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Greeting Message
                    Text(
                      'Apa yang ingin kamu tanya atau bagikan?',
                      style: TextStyle(color: neutral70, fontSize: 14.0),
                    ),
                    // Icon Create Content
                    IconButton(
                      icon: Icon(IconsaxPlusLinear.edit),
                      onPressed: () {
                        // Logika pencarian
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            // Terpopuler
            Row(
              children: [
                Text(
                  'Terpopuler',
                  style: mediumTS.copyWith(fontSize: 18, color: neutral100),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                IconButton(
                  icon: const Icon(IconsaxPlusLinear.arrow_down, size: 16.0),
                  onPressed: () {
                    // Nothing
                  },
                ),
              ],
            ),
        
            const SizedBox(height: small),
        
            Expanded(
              child: PItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: PItems.length,
                      itemBuilder: (context, index) {
                        return PostCard(
                            showText: false, postcard: PItems[index]);
                      },
                    )
                  : const NoActivityLayout(),
            ),
          ],
        ),
      ),
    );
  }
}
