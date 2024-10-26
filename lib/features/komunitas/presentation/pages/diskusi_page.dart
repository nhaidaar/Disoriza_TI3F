import 'package:flutter/material.dart';

import '../../../../core/common/custom_dropdown.dart';
import '../widgets/create_post_button.dart';
import '../widgets/post_card.dart';

class DiskusiPage extends StatelessWidget {
  const DiskusiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Create Post Widget
        const CreatePostButton(),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Filter post
              Row(
                children: [
                  CustomDropdown(
                    items: const ['Terpopuler', 'Terbaru'],
                    initialValue: 'Terpopuler',
                    onChanged: (value) {},
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ...List.generate(6, (index) {
                return PostCard(
                  title: 'Cara mendapatkan pestida',
                  text:
                      'Hawar daun bakteri adalah penyakit yang disebabkan oleh bakteri Xanthomonas oryzae pv. oryzae, yang merupakan salah satu penyakit paling merusak pada tanaman padi. Penyakit ini menyerang daun, menyebabkan daun menjadi kuning, layu, dan akhirnya kering. Jika infeksi parah, tanaman dapat mati sebelum mencapai fase pematangan.',
                  image: index % 2 == 0
                      ? 'assets/images/main.jpg'
                      : index % 3 == 0
                          ? 'assets/images/cardhist.jpeg'
                          : null,
                );
              }),
            ],
          ),
        )
      ],
    );
  }
}
