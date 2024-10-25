import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool isEmailEmpty = true;

  @override
  void initState() {
    _emailController.addListener(updateFieldState);
    super.initState();
  }

  void updateFieldState() {
    setState(() => isEmailEmpty = _emailController.text.isEmpty);
  }

  @override
  void dispose() {
    _emailController.removeListener(updateFieldState);
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
                  'Reset password',
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
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Masukkan email anda',
                ),

                const SizedBox(height: 24),

                // Submit button
                CustomButton(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => CustomPopup(
                      icon: IconsaxPlusBold.tick_circle,
                      iconColor: accentGreenMain,
                      title: 'Email terkirim!',
                      subtitle: 'Kami telah mengirim link reset password ke email naufal@mail.com',
                      actions: [
                        CustomButton(
                          onTap: () => Navigator.of(context).pop(),
                          text: 'Oke',
                        ),
                      ],
                    ),
                  ),
                  disabled: isEmailEmpty,
                  text: 'Konfirmasi',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
