import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/fontstyles.dart';
import '../widgets/setelan_menu.dart';
import 'edit_profile_page.dart';
import 'ubah_password_page.dart';

class SetelanPage extends StatelessWidget {
  const SetelanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutral10,
        surfaceTintColor: neutral10,
        shape: const Border(
          bottom: BorderSide(color: neutral30),
        ),
        title: Text(
          'Setelan',
          style: mediumTS.copyWith(color: neutral100),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          SetelanMenu(
            icon: IconsaxPlusLinear.profile,
            title: 'Edit profile',
            onTap: () => Navigator.of(context).push(
              PageTransition(
                child: const EditProfilePage(),
                type: PageTransitionType.rightToLeft,
              ),
            ),
          ),
          SetelanMenu(
            icon: IconsaxPlusLinear.key,
            title: 'Ubah password',
            onTap: () => Navigator.of(context).push(
              PageTransition(
                child: const UbahPasswordPage(),
                type: PageTransitionType.rightToLeft,
              ),
            ),
          ),
          SetelanMenu(
            icon: IconsaxPlusLinear.logout,
            iconColor: dangerMain,
            enableArrowRight: false,
            title: 'Keluar',
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return CustomPopup(
                  icon: IconsaxPlusLinear.logout,
                  iconColor: dangerMain,
                  title: 'Ingin keluar?',
                  subtitle: 'Setelah keluar dari aplikasi, kamu dapat login kembali.',
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            backgroundColor: dangerMain,
                            pressedColor: dangerPressed,
                            text: 'Ya, keluar',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: CustomButton(
                            backgroundColor: neutral10,
                            pressedColor: neutral50,
                            text: 'Batal',
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
