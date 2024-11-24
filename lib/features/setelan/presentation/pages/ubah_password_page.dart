import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../Setelan/presentation/cubit/setelan_cubit.dart';
import '../../../auth/data/models/user_model.dart';

class UbahPasswordPage extends StatefulWidget {
  final UserModel user;
  const UbahPasswordPage({super.key, required this.user});

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.user.email.toString();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(IconsaxPlusLinear.arrow_left),
        ),
        backgroundColor: neutral10,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: neutral10,
            child: Column(
              children: [
                // Title
                Text(
                  'Ubah password',
                  style: mediumTS.copyWith(fontSize: 24, color: neutral100),
                ),

                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'Masukkan email anda untuk mendapatkan link reset password.',
                  style: mediumTS.copyWith(color: neutral100.withOpacity(0.6)),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              children: [
                // Email Field
                const Text(
                  'Email',
                  style: mediumTS,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  isEnabled: false,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Masukkan email anda',
                ),

                const SizedBox(height: 24),

                // Submit button
                CustomButton(
                  onTap: () => context.read<SetelanCubit>().resetPassword(email: _emailController.text),
                  text: 'Konfirmasi',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleUbahPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
        icon: IconsaxPlusBold.tick_circle,
        iconColor: accentGreenMain,
        title: 'Email terkirim!',
        subtitle: 'Kami telah mengirimkan link ubah password ke email ${_emailController.text}',
        actions: [
          CustomButton(
            onTap: () => Navigator.of(context).pop(),
            text: 'Oke',
          ),
        ],
      ),
    );
  }
}
