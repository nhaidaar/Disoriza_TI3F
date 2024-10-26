import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../widgets/riwayat_card.dart';
import '../../../home/presentation/widgets/beranda_empty_state.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final _searchController = TextEditingController();

  bool isRiwayatEmpty = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 128,
        backgroundColor: neutral10,
        surfaceTintColor: neutral10,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Riwayat pemindaian',
              style: mediumTS.copyWith(color: neutral100),
            ),

            const SizedBox(height: 16),

            // Search Field
            CustomFormField(
              controller: _searchController,
              hint: 'Cari judul penyakit',
              backgroundColor: backgroundCanvas,
              prefixIcon: IconsaxPlusLinear.search_normal,
              prefixIconColor: neutral60,
            ),
          ],
        ),
      ),
      body: !isRiwayatEmpty
          ? ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(10, (index) {
                    return const RiwayatCard(
                      image: 'assets/images/cardhist.jpeg',
                      title: 'Bacterial Leaf Blight',
                      timeAgo: '30 menit lalu',
                    );
                  }),
                ),
              ],
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: RiwayatEmptyState()),
              ],
            ),
    );
  }
}
