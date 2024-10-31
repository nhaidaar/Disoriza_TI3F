import 'package:flutter/material.dart';

import 'colors.dart';
import 'fontstyles.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? pressedColor;
  final IconData? icon;
  final String text;
  final bool disabled;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    this.icon,
    this.backgroundColor = accentOrangeMain,
    this.pressedColor = accentOrangePressed,
    required this.text,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !disabled ? onTap : null,
      splashColor: !disabled ? pressedColor : null,
      highlightColor: !disabled ? pressedColor : null,
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: !disabled ? backgroundColor : neutral30,
          borderRadius: BorderRadius.circular(40),
          border: backgroundColor == neutral10 ? Border.all(color: neutral30) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: neutral10, size: 20),
            if (icon != null) const SizedBox(width: 8),
            Text(
              text,
              style: mediumTS.copyWith(
                fontSize: 16,
                color: backgroundColor == neutral10 ? neutral100 : neutral10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomLoadingButton extends StatelessWidget {
  final Color backgroundColor;
  const CustomLoadingButton({
    super.key,
    this.backgroundColor = accentOrangeMain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(40),
        border: backgroundColor == neutral10 ? Border.all(color: neutral30) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 23,
            width: 23,
            child: CircularProgressIndicator(
              color: backgroundColor == neutral10 ? neutral30 : neutral10,
            ),
          ),
        ],
      ),
    );
  }
}
