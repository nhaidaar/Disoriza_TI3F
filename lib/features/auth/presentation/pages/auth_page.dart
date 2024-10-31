import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../home/presentation/pages/home_onboarding.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../home/presentation/widgets/disoriza_logo.dart';
import '../cubit/auth_cubit.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                child: state.isFirstTime
                    ? HomeOnboarding(user: state.user)
                    : HomeScreen(user: state.user),
                type: PageTransitionType.fade,
              ),
              (route) => false,
            );
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                color: neutral10,
                child: Column(
                  children: [
                    const DisorizaLogo(),

                    const SizedBox(height: 16),

                    // Greeting messages
                    Text(
                      'Selamat Datang di Disoriza!',
                      style: mediumTS.copyWith(fontSize: 24, color: neutral100),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Jelajahi fitur pemindai untuk mengetahui penyakit pada padi.',
                      style: mediumTS.copyWith(color: neutral70),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Buat Akun dan Masuk (Tab Bar)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: backgroundCanvas,
                      ),
                      child: TabBar(
                        labelStyle: mediumTS.copyWith(
                            fontSize: 16, color: accentGreenMain),
                        unselectedLabelStyle:
                            mediumTS.copyWith(fontSize: 16, color: neutral60),
                        indicator: BoxDecoration(
                          color: neutral10,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        splashBorderRadius: BorderRadius.circular(100),
                        dividerHeight: 0,
                        tabs: const [
                          Tab(text: 'Buat Akun'),
                          Tab(text: 'Masuk'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Buat Akun dan Masuk (Page)
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    RegisterPage(),
                    LoginPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
