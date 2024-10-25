import 'package:disoriza/core/common/effects.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';
import '../pages/history_detail.dart';

class HistoryCard extends StatelessWidget {
  final String image;
  final String title;
  final String timeAgo;

  const HistoryCard({
    super.key,
    required this.image,
    required this.title,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            child: const DetailRiwayat(),
            type: PageTransitionType.rightToLeft,
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        decoration: ShapeDecoration(
          color: neutral10,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(cornerRadius: 16),
          ),
          shadows: const [shadowEffect1],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              height: 102,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: mediumTS.copyWith(color: neutral100),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeAgo,
                    style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
