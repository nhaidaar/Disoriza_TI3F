import 'package:flutter/material.dart';

import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';

class HistoryCard extends StatelessWidget {
  final String image;
  final String title;
  final String timeAgo;

  const HistoryCard({
    Key? key,
    required this.image,
    required this.title,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 163,
      height: 154,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        color: neutral10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 1),
              child: Text(
                title,
                style: mediumTS.copyWith(color: neutral100)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                timeAgo,
                style: mediumTS.copyWith(color: neutral70)
              ),
            ),
          ],
        ),
      ),
    );
  }
}


