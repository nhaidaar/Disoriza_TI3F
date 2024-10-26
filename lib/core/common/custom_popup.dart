import 'package:flutter/material.dart';

import 'colors.dart';
import 'effects.dart';
import 'fontstyles.dart';

class CustomPopup extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  const CustomPopup({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: defaultSmoothRadius,
      ),
      backgroundColor: neutral10,
      titlePadding: const EdgeInsets.all(12),
      title: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: defaultSmoothRadius,
          color: backgroundCanvas,
        ),
        child: Column(
          children: [
            // Custom Icon
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),

            const SizedBox(height: 8),

            // Message Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: mediumTS.copyWith(fontSize: 18, color: neutral100),
            ),

            if (subtitle != null) ...[
              const SizedBox(height: 8),

              // Message subtitle
              Text(
                subtitle.toString(),
                textAlign: TextAlign.center,
                style: mediumTS.copyWith(fontSize: 14, color: neutral90),
              ),
            ]
          ],
        ),
      ),

      // Actions (maybe some button)
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.all(8),
      actions: actions,
    );
  }
}
