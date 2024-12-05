import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';

class SetelanMenu extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final VoidCallback? onTap;
  final bool enableArrowRight;
  const SetelanMenu({
    super.key,
    required this.icon,
    this.iconColor = neutral100,
    required this.title,
    this.onTap,
    this.enableArrowRight = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: InkWell(
        onTap: onTap,
        splashColor: neutral50,
        highlightColor: neutral50,
        customBorder: RoundedRectangleBorder(
          borderRadius: defaultSmoothRadius,
        ),
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: defaultSmoothRadius,
            color: neutral10,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: backgroundCanvas,
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: mediumTS.copyWith(color: iconColor),
              ),
              const Spacer(),
              if (enableArrowRight) Icon(IconsaxPlusLinear.arrow_right_3, color: iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
