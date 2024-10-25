import 'package:flutter/material.dart';

import 'colors.dart';
import 'fontstyles.dart';

class CustomPopup extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final List<Widget> actions;
  const CustomPopup({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: neutral10,
      titlePadding: const EdgeInsets.all(12),
      title: Padding(
        padding: const EdgeInsets.all(8),
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

            const SizedBox(height: 8),

            // Message subtitle
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: mediumTS.copyWith(fontSize: 14, color: neutral90),
            ),
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
