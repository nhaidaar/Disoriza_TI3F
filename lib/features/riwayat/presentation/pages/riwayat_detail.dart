import 'package:disoriza/core/common/effects.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../home/presentation/widgets/disoriza_logo.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';
import '../widgets/riwayat_detail_card.dart';
import '../widgets/riwayat_detail_remote.dart';

class RiwayatDetail extends StatefulWidget {
  const RiwayatDetail({super.key});

  @override
  State<RiwayatDetail> createState() => _RiwayatDetailState();
}

class _RiwayatDetailState extends State<RiwayatDetail> {
  final _scrollController = AutoScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: neutral10,
        surfaceTintColor: neutral10,

        // Back Button
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(IconsaxPlusLinear.arrow_left),
        ),

        // Logo
        title: const DisorizaLogo(),
        centerTitle: true,

        // Delete Button
        actions: [
          IconButton(
            onPressed: () => handleDeleteRiwayat(context),
            icon: const Icon(IconsaxPlusLinear.trash, color: dangerMain),
          ),
        ],
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        children: [
          // About the diseases
          Container(
            height: 380,
            decoration: BoxDecoration(
              borderRadius: defaultSmoothRadius,
              image: const DecorationImage(
                image: AssetImage('assets/images/cardhist.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: defaultSmoothRadius,
                    color: neutral10,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jenis penyakit',
                            style: mediumTS.copyWith(color: neutral70),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Bacterial Leaf Blight',
                            style: mediumTS.copyWith(fontSize: 18, color: neutral100),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          IconsaxPlusBold.scan,
                          color: neutral10,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Definisi
          RiwayatDetailCard(
            index: 0,
            controller: _scrollController,
            title: 'Definisi',
            content:
                'Hawar daun bakteri adalah penyakit yang disebabkan oleh bakteri Xanthomonas oryzae pv. oryzae, yang merupakan salah satu penyakit paling merusak pada tanaman padi. Penyakit ini menyerang daun, menyebabkan daun menjadi kuning, layu, dan akhirnya kering. Jika infeksi parah, tanaman dapat mati sebelum mencapai fase pematangan.',
          ),

          const SizedBox(height: 8),

          // Gejala
          RiwayatDetailCard(
            index: 1,
            controller: _scrollController,
            title: 'Gejala',
            content:
                '1. Awalnya, muncul garis-garis atau bercak-bercak kecil berwarna hijau gelap pada tepi daun.\n2. Bercak tersebut kemudian membesar dan memanjang, berwarna coklat kekuningan, sehingga menyebabkan daun menjadi layu dan mati.\n3. Pada kondisi lembab, penyakit ini dapat menyebar dengan cepat, mengakibatkan kerusakan yang lebih parah.\n4. Pada infeksi berat, tanaman bisa mengalami kematian dini, yang sangat mempengaruhi hasil panen.',
          ),

          const SizedBox(height: 8),

          // Solusi
          RiwayatDetailCard(
            index: 2,
            controller: _scrollController,
            title: 'Solusi',
            content:
                '1. Penggunaan Varietas Tahan\nMenanam varietas padi yang tahan terhadap Xanthomonas oryzae pv. oryzae merupakan salah satu cara yang efektif untuk mengurangi risiko serangan penyakit ini.\n2. Pengaturan Irigasi \nMenghindari genangan air yang berlebihan dan mengatur sistem irigasi dengan baik dapat membantu mengurangi penyebaran bakteri. Irigasi yang berlebihan dapat memperparah penyebaran penyakit ini.\n3. Rotasi Tanaman \nMelakukan rotasi tanaman dengan tanaman non- padi untuk memutus siklus hidup bakteri penyebab penyakit ini.\n4. Pengendalian Serangga Vektor \nMengendalikan serangga vektor yang bisa menyebarkan bakteri, seperti wereng hijau, juga penting dalam manajemen penyakit ini.\n5. Aplikasi Bakterisida \nJika serangan sudah terjadi, penggunaan bakterisida berbahan dasar tembaga (copper- based bactericides) dapat digunakan untuk mengurangi penyebaran infeksi. Namun, efektivitasnya terbatas dan harus digunakan sebagai upaya terakhir.',
          ),

          const SizedBox(height: 150),
        ],
      ),

      // Section Remote
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(40),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          border: Border.all(color: neutral30),
          color: neutral10,
          boxShadow: const [shadowEffect1],
        ),
        child: Row(
          children: [
            RiwayatDetailRemote(
              title: 'Definisi',
              isActive: _currentIndex == 0,
              onTap: () => _scrollToIndex(0),
            ),
            const SizedBox(width: 4),
            RiwayatDetailRemote(
              title: 'Gejala',
              isActive: _currentIndex == 1,
              onTap: () => _scrollToIndex(1),
            ),
            const SizedBox(width: 4),
            RiwayatDetailRemote(
              title: 'Solusi',
              isActive: _currentIndex == 2,
              onTap: () => _scrollToIndex(2),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleDeleteRiwayat(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => CustomPopup(
        icon: IconsaxPlusLinear.trash,
        iconColor: dangerMain,
        title: 'Ingin menghapus riwayat ini?',
        subtitle: 'Setelah dihapus, data tidak dapat diurungkan.',
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  backgroundColor: dangerMain,
                  pressedColor: dangerPressed,
                  onTap: () {},
                  text: 'Ya, hapus',
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: CustomButton(
                  backgroundColor: Colors.transparent,
                  pressedColor: neutral50,
                  onTap: () => Navigator.of(context).pop(),
                  text: 'Batal',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onScroll() {
    // Get the current scroll position
    final double viewportHeight = _scrollController.position.viewportDimension;
    final double screenTriggerOffset = viewportHeight * 0.3; // 30% of screen height

    // Check each section's position
    for (int i = 0; i < 3; i++) {
      final RenderObject? renderObject = _scrollController.tagMap[i]?.context.findRenderObject();

      if (renderObject is RenderBox) {
        final position = renderObject.localToGlobal(Offset.zero);
        final itemOffset = position.dy - _scrollController.offset;

        // Consider a section "active" when its top portion is in the upper part of the screen
        if (itemOffset <= screenTriggerOffset) {
          // Check if this is the last visible section
          if (i == 2 ||
              (_scrollController.tagMap[i + 1]?.context.findRenderObject() as RenderBox?)!
                      .localToGlobal(Offset.zero)
                      .dy >
                  screenTriggerOffset) {
            if (_currentIndex != i) {
              setState(() => _currentIndex = i);
            }
            break;
          }
        }
      }
    }
  }

  Future _scrollToIndex(int index) async {
    // Calculate offset based on screen height
    final double viewportHeight = _scrollController.position.viewportDimension;
    final double offset = viewportHeight * 0.15; // 15% of screen height

    await _scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);

    // Apply additional offset after scrolling to position
    final targetContext = _scrollController.tagMap[index]?.context;
    if (targetContext != null) {
      // ignore: use_build_context_synchronously
      final RenderObject? renderObject = targetContext.findRenderObject();
      if (renderObject is RenderBox) {
        final position = renderObject.localToGlobal(Offset.zero);
        final scrollOffset = _scrollController.offset + position.dy - offset;

        await _scrollController.animateTo(
          scrollOffset,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    }

    setState(() => _currentIndex = index);
  }
}
