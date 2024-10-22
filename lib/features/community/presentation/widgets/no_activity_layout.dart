import 'package:disoriza/core/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:disoriza/core/common/paddings.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class NoActivityLayout extends StatelessWidget {
  const NoActivityLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(xSmall),
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(small),
            child: const Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Icon(
                  IconsaxPlusLinear.clipboard_close,
                  color: neutral60,
                ),
                SizedBox(height: 8),
                Text(
                  'Belum ada aktivitas yang bisa ditampilkan',
                  style: TextStyle(color: neutral60),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
