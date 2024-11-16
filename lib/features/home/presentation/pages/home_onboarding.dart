import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/custom_button.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';
import '../widgets/disoriza_logo.dart';
import 'home_screen.dart';

class HomeOnboarding extends StatelessWidget {
  final Client client;
  final User user;
  const HomeOnboarding({
    super.key,
    required this.client,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral10,
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            const DisorizaLogo(),

            const SizedBox(height: 16),

            // Greeting Message
            RichText(
              text: TextSpan(
                text: 'Hai Naufal, Yuk mulai pemindaian pertamamu menggunakan ',
                style: mediumTS.copyWith(fontSize: 24, color: neutral100),
                children: [
                  TextSpan(
                    text: 'Disoriza AI ✨',
                    style: mediumTS.copyWith(fontSize: 24, color: accentGreenMain),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Description Text
            Text(
              'Ayo coba fitur pindai yang dimiliki aplikasi ini untuk mengetahui penyakit pada padi Anda.',
              style: mediumTS.copyWith(color: neutral70),
            ),

            const SizedBox(height: 24),

            // Pindai Button
            CustomButton(
              icon: IconsaxPlusLinear.scanner,
              text: 'Pindai',
              onTap: () {},
            ),

            const SizedBox(height: 12),

            // Lewati
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                    child: HomeScreen(client: client, user: user),
                    type: PageTransitionType.fade,
                  ),
                  (route) => false,
                );
              },
              child: Center(
                child: Text(
                  'Lewati',
                  style: mediumTS.copyWith(color: neutral70),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
