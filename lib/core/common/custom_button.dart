import 'package:flutter/material.dart';

import 'colors.dart';
import 'fontstyles.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final bool disabled;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    this.icon,
    required this.text,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !disabled ? onTap : null,
      splashColor: !disabled ? accentOrangePressed : null,
      highlightColor: !disabled ? accentOrangePressed : null,
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: !disabled ? accentOrangeMain : neutral30,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: neutral10, size: 20),
            if (icon != null) const SizedBox(width: 8),
            Text(
              text,
              style: mediumTS.copyWith(fontSize: 16, color: neutral10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
