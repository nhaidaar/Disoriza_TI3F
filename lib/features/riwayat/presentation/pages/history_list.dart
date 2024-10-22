import 'package:disoriza/features/riwayat/presentation/widgets/history_card.dart';
import 'package:disoriza/features/riwayat/presentation/pages/history_detail.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';

class ListRiwayat extends StatelessWidget {
  const ListRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundComponent,
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Riwayat pemindaian',
                style: mediumTS.copyWith(color: neutral100),
              ),
              const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: backgroundCanvas,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                        hintText: 'Cari judul penyakit',
                        hintStyle: mediumTS.copyWith(fontSize: 14, color: neutral60),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon:
                          Icon(IconsaxPlusLinear.search_normal, color: neutral60),
                          prefixIconConstraints: BoxConstraints(minWidth: 25,minHeight: 25)
                        ),
                    )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DetailRiwayat(),
                ),
              );
            },
            child: HistoryCard(
              image: 'assets/images/cardhist.jpeg',
              title: 'Bacterial Leaf Blight',
              timeAgo: '30 menit lalu',
            ),
          );
        },
      )
      ),
    );
  }
}
