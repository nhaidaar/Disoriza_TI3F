import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';

class BerandaKomunitasCard extends StatelessWidget {
  const BerandaKomunitasCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: neutral10,
        border: Border.all(color: neutral30),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // User
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: neutral30,
                child: Icon(IconsaxPlusLinear.profile, color: neutral100),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wahyu Utami',
                    style: mediumTS.copyWith(color: neutral100),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '12 hours ago',
                    style: mediumTS.copyWith(fontSize: 12, color: neutral60),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 12),

          // Post
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cara mendapatkan pestida',
                      style: semiboldTS.copyWith(fontSize: 16, color: neutral100),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Hawar daun bakteri adalah penyakit yang disebabkan oleh bakteri Xanthomonas oryzae pv. oryzae, yang merupakan salah satu penyakit paling merusak pada tanaman padi. Penyakit ini menyerang daun, menyebabkan daun menjadi kuning, layu, dan akhirnya kering. Jika infeksi parah, tanaman dapat mati sebelum mencapai fase pematangan.',
                      style: mediumTS.copyWith(color: neutral90),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 84,
                width: 78,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: backgroundCanvas,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 12),

          // Like and Comment count

          Row(
            children: [
              // Like
              Icon(
                IconsaxPlusBold.heart,
                color: Colors.red,
              ),
              const SizedBox(width: 4),
              Text(
                '12',
                style: mediumTS.copyWith(fontSize: 12, color: neutral80),
              ),

              const SizedBox(width: 16),

              // Comment
              Icon(
                IconsaxPlusLinear.message_text_1,
                color: neutral100,
              ),
              const SizedBox(width: 4),
              Text(
                '12',
                style: mediumTS.copyWith(fontSize: 12, color: neutral80),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
