import 'package:disoriza/core/common/effects.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';

class RiwayatCard extends StatelessWidget {
  // final String id;
  final String image;
  final String title;
  final String timeAgo;
  final VoidCallback onTap;
  
  const RiwayatCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.timeAgo,
    // required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        decoration: BoxDecoration(
          color: neutral10,
          borderRadius: defaultSmoothRadius,
          boxShadow: const [shadowEffect1],
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

