import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/fontstyles.dart';
import '../widgets/disoriza_logo.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            toolbarHeight: 70,
            backgroundColor: backgroundCanvas,
            title: Row(
              children: [
                // Avatar
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: neutral10,
                  child: Icon(IconsaxPlusLinear.profile, color: neutral100),
                ),

                const SizedBox(width: 8),

                // Greeting Message
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang, ',
                      style: regularTS.copyWith(fontSize: 14, color: neutral100),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Naufal Haidar',
                      style: mediumTS.copyWith(fontSize: 18, color: neutral100),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
        body: ListView(
          children: [
            // Pindai dengan Disoriza AI
            const BerandaPindaiWidget(),

            // Diskusi & Riwayat
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Diskusi petani
                  Row(
                    children: [
                      Text(
                        'Diskusi petani',
                        style: mediumTS.copyWith(fontSize: 18, color: neutral100),
                      ),
                      const Spacer(),
                      Text(
                        'Lihat semua',
                        style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        const Icon(
                          IconsaxPlusLinear.clipboard_close,
                          size: 28,
                          color: neutral60,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Belum ada diskusi yang bisa ditampilkan',
                          style: mediumTS.copyWith(color: neutral60),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Riwayat Scan
                  Row(
                    children: [
                      Text(
                        'Riwayat terbaru',
                        style: mediumTS.copyWith(fontSize: 18, color: neutral100),
                      ),
                      const Spacer(),
                      Text(
                        'Lihat semua',
                        style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        const Icon(
                          IconsaxPlusLinear.clipboard_close,
                          size: 28,
                          color: neutral60,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Belum ada diskusi yang bisa ditampilkan',
                          style: mediumTS.copyWith(color: neutral60),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BerandaPindaiWidget extends StatelessWidget {
  const BerandaPindaiWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Logo
          const DisorizaLogo(),

          const SizedBox(height: 12),

          // Text
          Text(
            'Pindai dengan Disoriza AI ✨',
            style: mediumTS.copyWith(fontSize: 20, color: neutral10),
          ),
          const SizedBox(height: 4),
          Text(
            'Pindai untuk mengetahui penyakit pada padi.',
            style: mediumTS.copyWith(fontSize: 14, color: neutral10),
          ),

          const SizedBox(height: 24),

          // Button
          Container(
            decoration: BoxDecoration(
              color: accentOrangeMain,
              borderRadius: BorderRadius.circular(40),
            ),
            child: CustomButton(
              icon: IconsaxPlusBold.scan,
              text: 'Pindai',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
