import 'package:flutter/material.dart';

import 'colors.dart';
import 'fontstyles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    required this.text,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !disabled ? onTap : null,
      splashColor: !disabled ? orangePressed : null,
      highlightColor: !disabled ? orangePressed : null,
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: !disabled ? orange : neutral30,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          text,
          style: mediumTS.copyWith(fontSize: 16, color: neutral10),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
