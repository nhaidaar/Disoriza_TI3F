import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'colors.dart';
import 'fontstyles.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Color? backgroundColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final bool obscureText;
  final bool isPassword;
  final bool isEnabled;
  final int maxLines;
  final double borderradius;
  final String? hint;
  final VoidCallback? onTap;
  const CustomFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.backgroundColor = neutral10,
    this.prefixIcon,
    this.prefixIconColor,
    this.obscureText = false,
    this.isPassword = false,
    this.isEnabled = true,
    this.maxLines = 1,
    this.borderradius = 40.0,
    this.hint,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1 : 0.6,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: mediumTS.copyWith(fontSize: 14, color: isEnabled ? neutral100 : neutral60),
        maxLines: maxLines,
        decoration: InputDecoration(
          enabled: isEnabled,
          filled: true,
          fillColor: backgroundColor,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: prefixIconColor) : null,
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: onTap,
                  child: !obscureText
                      ? const Icon(IconsaxPlusLinear.eye)
                      : const Icon(IconsaxPlusLinear.eye_slash),
                )
              : null,
          hintText: hint,
          hintStyle: mediumTS.copyWith(fontSize: 14, color: neutral60),
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderradius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderradius),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderradius),
          ),
        ),
      ),
    );
  }
}
