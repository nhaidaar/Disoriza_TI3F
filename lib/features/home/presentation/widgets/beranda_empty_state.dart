import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';

class CustomEmptyState extends StatelessWidget {
  final IconData icon;
  final String text;
  const CustomEmptyState({super.key, required this.icon, required this.text});

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

class DiskusiEmptyState extends StatelessWidget {
  const DiskusiEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomEmptyState(
      icon: IconsaxPlusLinear.clipboard_close,
      text: 'Belum ada diskusi yang bisa ditampilkan',
    );
  }
}

class RiwayatEmptyState extends StatelessWidget {
  const RiwayatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomEmptyState(
      icon: IconsaxPlusLinear.clipboard_close,
      text: 'Belum ada riwayat yang bisa ditampilkan',
    );
  }
}
