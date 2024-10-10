import 'package:flutter/material.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                color: neutral10,
                child: Column(
                  children: [
                    // Disoriza Logo
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: neutral10,
                        boxShadow: const [shadowEffect0, shadowEffect1],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        scale: 3,
                        color: green,
                      ),
                    ),

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
                        color: background,
                      ),
                      child: TabBar(
                        labelStyle: mediumTS.copyWith(fontSize: 16, color: green),
                        unselectedLabelStyle: mediumTS.copyWith(fontSize: 16, color: neutral60),
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
