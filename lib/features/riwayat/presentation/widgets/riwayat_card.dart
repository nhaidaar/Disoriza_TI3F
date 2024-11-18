import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common/colors.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../data/models/riwayat_model.dart';
import '../pages/riwayat_detail.dart';

class RiwayatCard extends StatelessWidget {
  final RiwayatModel riwayatModel;

  const RiwayatCard({super.key, required this.riwayatModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
            child: RiwayatDetail(riwayat: riwayatModel),
            type: PageTransitionType.leftToRight,
          ),
        );
      },
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
              riwayatModel.urlImage.toString(),
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
                    riwayatModel.idDisease!.name.toString(),
                    style: mediumTS.copyWith(color: neutral100),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeago.format(riwayatModel.date ?? DateTime.now()),
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
