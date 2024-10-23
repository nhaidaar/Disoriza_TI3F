import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/paddings.dart';
import 'package:disoriza/core/common/fontstyles.dart';

import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class DiscussionTab extends StatelessWidget {
  const DiscussionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: SizedBox(height: 8.0),
          ),
          SliverAppBar(
            floating: true,
            snap: true,
            toolbarHeight: 70,
            backgroundColor: neutral10,
            title: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: backgroundCanvas,
                borderRadius: BorderRadius.circular(40.0),
              ),
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
        ],
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: small),
        ),
      ),
    );
  }
}
