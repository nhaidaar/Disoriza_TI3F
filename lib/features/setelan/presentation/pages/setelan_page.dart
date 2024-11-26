import 'package:disoriza/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../auth/presentation/blocs/auth_bloc.dart';
import '../blocs/setelan_bloc.dart';
import '../widgets/setelan_menu.dart';
import 'edit_profile_page.dart';
import 'ubah_email_page.dart';
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
    final authBloc = context.read<AuthBloc>();
    final setelanBloc = context.read<SetelanBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) Navigator.of(context).pop(); // Pop the logout popup
      },
      child: Scaffold(
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
                    value: setelanBloc,
                    child: EditProfilePage(user: widget.user),
                  ),
                  type: PageTransitionType.rightToLeft,
                ),
              ),
            ),
            SetelanMenu(
              icon: IconsaxPlusLinear.sms,
              title: 'Ubah email',
              onTap: () => Navigator.of(context).push(
                PageTransition(
                  child: BlocProvider.value(
                    value: setelanBloc,
                    child: UbahEmailPage(user: widget.user),
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
                    value: setelanBloc,
                    child: UbahPasswordPage(user: widget.user),
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
              onTap: () => handleLogout(context, authBloc),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleLogout(BuildContext context, AuthBloc authBloc) {
    return showDialog(
      context: context,
      builder: (context) => CustomPopup(
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
                  onTap: () => authBloc.add(AuthLogout()),
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
    );
  }
}
