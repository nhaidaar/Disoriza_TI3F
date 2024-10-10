import 'package:flutter/material.dart';

import 'features/home/presentation/pages/splash_screen.dart';

void main() {
  runApp(const Disoriza());
}

class Disoriza extends StatelessWidget {
  const Disoriza({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Disoriza',
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
