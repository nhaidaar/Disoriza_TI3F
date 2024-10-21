import 'package:disoriza/core/common/paddings.dart';
import 'package:disoriza/features/community/presentation/pages/activity_tab.dart';
import 'package:disoriza/features/community/presentation/pages/discussion_tab.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/colors.dart';
import '../../../../../core/common/fontstyles.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Komunitas',
              style: mediumTS.copyWith(fontSize: 24, color: neutral100),
            ),
            backgroundColor: neutral10,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(92),
              child: Container(
                padding: const EdgeInsets.only(
                  left: large,
                  right: large,
                  bottom: large,
                ),
                color: neutral10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: backgroundCanvas,
                  ),
                  child: TabBar(
                    labelStyle: mediumTS.copyWith(fontSize: 16, color: accentGreenMain),
                    unselectedLabelStyle: mediumTS.copyWith(fontSize: 16, color: neutral60),
                    indicator: BoxDecoration(
                      color: neutral10,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    splashBorderRadius: BorderRadius.circular(100),
                    dividerHeight: 0,
                    tabs: const [
                      Tab(text: 'Diskusi'),
                      Tab(text: 'Aktivitasmu'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(vertical: small),
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      DiscussionTab(),
                      ActivityTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
