import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../cubit/auth_cubit.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  bool passwordHidden = true;
  bool areFieldsEmpty = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(updateFieldState);
    _passwordController.addListener(updateFieldState);
  }

  void updateFieldState() {
    setState(() {
      areFieldsEmpty = _emailController.text.isEmpty || _passwordController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(updateFieldState);
    _passwordController.removeListener(updateFieldState);
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          // Field email
          Text('Email', style: mediumTS.copyWith(color: neutral100)),
          const SizedBox(height: 8),
          CustomFormField(
            controller: _emailController,
            hint: 'Masukkan email anda',
          ),

          const SizedBox(height: 12),

          // Field password
          Text('Password', style: mediumTS.copyWith(color: neutral100)),
          const SizedBox(height: 8),
          CustomFormField(
            controller: _passwordController,
            focusNode: _passwordFocus,
            isPassword: true,
            hint: 'Masukkan password anda',
            obscureText: passwordHidden,
            onTap: () {
              setState(() => passwordHidden = !passwordHidden);
            },
          ),

          const SizedBox(height: 12),

          // Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: BlocProvider.value(
                        value: context.read<AuthCubit>(),
                        child: const ForgotPasswordPage(),
                      ),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                },
                child: Text(
                  'Lupa password?',
                  style: mediumTS.copyWith(color: neutral100),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Daftar Button
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is LoginLoading) return const CustomLoadingButton();
              return CustomButton(
                text: 'Masuk',
                disabled: areFieldsEmpty,
                onTap: () {
                  context.read<AuthCubit>().login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
