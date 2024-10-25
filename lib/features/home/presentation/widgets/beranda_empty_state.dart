import 'package:flutter/material.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';

class BerandaEmptyState extends StatelessWidget {
  final IconData icon;
  final String text;
  const BerandaEmptyState({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: neutral60,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: mediumTS.copyWith(color: neutral60),
          ),
        ],
      ),
    );
  }
}

// Container(
//   padding: const EdgeInsets.symmetric(vertical: 40),
//   child: Column(
//     children: [
//       const Icon(
//         IconsaxPlusLinear.clipboard_close,
//         size: 28,
//         color: neutral60,
//       ),
//       const SizedBox(height: 8),
//       Text(
//         'Belum ada diskusi yang bisa ditampilkan',
//         style: mediumTS.copyWith(color: neutral60),
//       ),
//     ],
//   ),
// ),