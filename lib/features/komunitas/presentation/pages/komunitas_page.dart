import 'package:disoriza/features/komunitas/presentation/pages/aktivitasmu_page.dart';
import 'package:disoriza/features/komunitas/presentation/pages/diskusi_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../../core/common/colors.dart';
import '../../../../../core/common/fontstyles.dart';

class KomunitasPage extends StatelessWidget {
  const KomunitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 128,
            backgroundColor: neutral10,
            surfaceTintColor: neutral10,
            shape: const Border(
              bottom: BorderSide(color: neutral30),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      'Komunitas',
                      style: mediumTS.copyWith(color: neutral100),
                    ),

                    // Search Icon
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(IconsaxPlusLinear.search_normal_1),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Diskusi dan Aktivitas (Tab Bar)
                Container(
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

                const SizedBox(height: 12),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              DiskusiPage(),
              AktivitasmuPage(),
            ],
          ),
        ),
      ),
    );
  }
}
