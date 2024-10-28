import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../widgets/post_card.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutral10,
        surfaceTintColor: neutral10,
        shape: const Border(
          bottom: BorderSide(color: neutral30),
        ),

        // Back Button
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(IconsaxPlusLinear.arrow_left),
        ),

        title: Text(
          'Detail diskusi',
          style: mediumTS.copyWith(fontSize: 16, color: neutral100),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: const [
                PostCard(
                  fullPost: true,
                  title: 'Cara mendapatkan pestida',
                  text:
                      'Hawar daun bakteri adalah penyakit yang disebabkan oleh bakteri Xanthomonas oryzae pv. oryzae, yang merupakan salah satu penyakit paling merusak pada tanaman padi. Penyakit ini menyerang daun, menyebabkan daun menjadi kuning, layu, dan akhirnya kering. Jika infeksi parah, tanaman dapat mati sebelum mencapai fase pematangan.',
                  image: 'assets/images/main.jpg',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border.symmetric(horizontal: BorderSide(color: neutral30)),
              color: neutral10,
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                CustomFormField(
                  controller: commentController,
                  backgroundColor: backgroundCanvas,
                  hint: 'Berikan komentar',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(IconsaxPlusLinear.send_1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
