import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../common/colors.dart';
import '../common/custom_button.dart';
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

void showDiseaseSehat(BuildContext context, {required VoidCallback? onScan}) async {
  showDialog(
    context: context,
    builder: (context) => CustomPopup(
      icon: IconsaxPlusBold.verify,
      iconColor: successMain,
      title: 'Tanaman sehat! 👍',
      subtitle: 'Padi yang dipindai sehat dan bebas dari infeksi. Terus jaga perawatannya untuk hasil yang maksimal!',
      actions: [
        CustomButton(
          onTap: onScan,
          text: 'Pindai Ulang',
          icon: IconsaxPlusLinear.scanner,
        ),
        CustomButton(
          onTap: () => Navigator.of(context).pop(),
          text: 'Batal',
          backgroundColor: neutral10,
          pressedColor: neutral50,
        ),
      ],
    ),
  );
}

void showDiseaseError(BuildContext context, {required VoidCallback? onScan}) async {
  showDialog(
    context: context,
    builder: (context) => CustomPopup(
      icon: IconsaxPlusBold.close_circle,
      iconColor: dangerMain,
      title: 'Gagal memindai!',
      subtitle: 'Maaf, pemindaian tidak berhasil.',
      actions: [
        CustomButton(
          onTap: onScan,
          text: 'Pindai Ulang.',
          icon: IconsaxPlusLinear.scanner,
        ),
        CustomButton(
          onTap: () => Navigator.of(context).pop(),
          text: 'Batal',
          backgroundColor: neutral10,
          pressedColor: neutral50,
        ),
      ],
    ),
  );
}
