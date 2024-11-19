import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/utils/snackbar.dart';
import '../cubit/auth_cubit.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) showSnackbar(context, message: state.message, isError: true);

        if (state is ResetPasswordSuccess) {
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              icon: IconsaxPlusBold.tick_circle,
              iconColor: accentGreenMain,
              title: 'Email terkirim!',
              subtitle: 'Kami telah mengirim link reset password ke email ${_emailController.text}',
              actions: [
                CustomButton(
                  onTap: () => Navigator.of(context).pop(),
                  text: 'Oke',
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
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
                    state is ResetPasswordLoading
                        ? const CustomLoadingButton()
                        : CustomButton(
                            onTap: () => context.read<AuthCubit>().resetPassword(email: _emailController.text),
                            disabled: isEmailEmpty,
                            text: 'Konfirmasi',
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
