import 'package:flutter/material.dart';

import 'core/common/colors.dart';
import 'features/home/presentation/pages/splash_screen.dart';

void main() {
  runApp(const Disoriza());
}

class Disoriza extends StatelessWidget {
  const Disoriza({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disoriza',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundCanvas,
      ),
      home: const SplashScreen(),
    );
  }
}
