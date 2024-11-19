import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../common/colors.dart';
import '../common/custom_popup.dart';

void showDiseaseLoading(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const CustomPopup(
      icon: IconsaxPlusBold.flash_1,
      iconColor: successMain,
      title: 'Sedang memproses',
      subtitle: 'Sabar ya, gambar sedang diproses.',
      isLoading: true,
    ),
  );
}
