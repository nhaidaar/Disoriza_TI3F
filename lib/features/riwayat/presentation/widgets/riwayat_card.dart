import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/common/colors.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../data/models/riwayat_model.dart';
import '../cubit/disease/disease_cubit.dart';
import '../cubit/riwayat/riwayat_cubit.dart';
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
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<RiwayatCubit>(),
                ),
                BlocProvider.value(
                  value: context.read<DiseaseCubit>(),
                ),
              ],
              child: RiwayatDetail(riwayat: riwayatModel),
            ),
            type: PageTransitionType.rightToLeft,
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
            CachedNetworkImage(
              imageUrl: riwayatModel.urlImage.toString(),
              errorWidget: (context, url, error) {
                return Image.asset(
                  'assets/images/example.jpg',
                  height: 102,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
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

class RiwayatLoadingCard extends StatelessWidget {
  const RiwayatLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(4, (index) {
        return CardLoading(
          height: 160,
          width: MediaQuery.of(context).size.width / 2 - 24,
          borderRadius: BorderRadius.circular(16),
        );
      }),
    );
  }
}
