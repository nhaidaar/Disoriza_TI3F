import 'package:disoriza/features/auth/data/models/user_model.dart';
import 'package:disoriza/features/setelan/presentation/cubit/setelan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../widgets/setelan_menu.dart';
import 'edit_profile_page.dart';
import 'ubah_password_page.dart';

class SetelanPage extends StatefulWidget {
  final UserModel user;
  const SetelanPage({super.key, required this.user});

  @override
  State<SetelanPage> createState() => _SetelanPageState();
}

class _SetelanPageState extends State<SetelanPage> {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

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
                child: BlocProvider.value(
                  value: context.read<SetelanCubit>(),
                  child: EditProfilePage(user: widget.user),
                ),
                type: PageTransitionType.rightToLeft,
              ),
            ),
          ),
          SetelanMenu(
            icon: IconsaxPlusLinear.key,
            title: 'Ubah password',
            onTap: () => Navigator.of(context).push(
              PageTransition(
                child: BlocProvider.value(
                  value: context.read<AuthCubit>(),
                  child: const UbahPasswordPage(),
                ),
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
              builder: (context) => CustomPopup(
                icon: IconsaxPlusLinear.logout,
                iconColor: dangerMain,
                title: 'Ingin keluar?',
                subtitle:
                    'Setelah keluar dari aplikasi, kamu dapat login kembali.',
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          backgroundColor: dangerMain,
                          pressedColor: dangerPressed,
                          text: 'Ya, keluar',
                          onTap: () async {
                            await authCubit.logout().then((_) {
                              Navigator.of(context).pop();
                            });
                          },
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
