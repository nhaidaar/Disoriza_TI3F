import 'package:flutter/material.dart';

import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/paddings.dart';

class CustomTabButton extends StatelessWidget {
  final String text;
  final int selectedIndex;
  final int tabIndex; // Tambahkan tabIndex untuk membedakan setiap tab
  final Function(int) onTabSelected;

  const CustomTabButton({
    super.key,
    required this.text,
    required this.onTabSelected,
    required this.selectedIndex,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == tabIndex; // Menentukan apakah tab dipilih
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () => onTabSelected(tabIndex),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? accentOrangeMain : neutral10,
          foregroundColor: isSelected ? neutral10 : neutral60,
          padding: const EdgeInsets.symmetric(horizontal: xMedium),
          shadowColor: Colors.transparent,
        ),
        child: Text(text),
      ),
    );
  }
}
