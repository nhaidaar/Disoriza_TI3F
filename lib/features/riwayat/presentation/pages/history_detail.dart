import 'package:disoriza/features/riwayat/presentation/widgets/history_detailContent.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../home/presentation/widgets/disoriza_logo.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';

class DetailRiwayat extends StatelessWidget {
  const DetailRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundComponent,
          toolbarHeight: 80,
          leading:                 
            IconButton(
                  icon: const Icon(IconsaxPlusLinear.arrow_left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
            ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                const DisorizaLogo(),
                IconButton(
                  icon: const Icon(IconsaxPlusLinear.trash),
                  color: dangerMain,
                  onPressed: () {
                   showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        backgroundColor: neutral10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Rounded corners
                        title: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: backgroundCanvas),
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Icon(IconsaxPlusLinear.trash, color: Colors.red, size: 24), // Trash can icon
                              const SizedBox(height: 8),
                              Text(
                                "Ingin menghapus riwayat ini?",
                                textAlign: TextAlign.center,
                                style: mediumTS.copyWith(color: neutral100, fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                " Setelah dihapus, data tidak dapat diurungkan. ",
                                textAlign: TextAlign.center,
                                style: mediumTS.copyWith(color: neutral90, fontSize: 14),
                              ),
                              const SizedBox(height: 16)
                            ],
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center, // Center align buttons
                        actions: [
                          SizedBox(
                            width: 120,
                            height: 44,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: neutral30, // Button text color
                                backgroundColor: dangerMain,
                                side: BorderSide(color: neutral30, width: 1)    // Button background color
                              ),
                              onPressed: () {
                                // Perform delete action
                                Navigator.of(context).pop();
                              },
                              child: Text("Ya, hapus", style: mediumTS.copyWith(color: neutral10, fontSize: 14),),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            height: 44,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: BorderSide(color: neutral30, width: 1) // Button text color
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Batal", style: mediumTS.copyWith(color: neutral100, fontSize: 14),),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 280, // Sesuaikan ukuran height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/cardhist.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jenis penyakit',
                                style: mediumTS.copyWith(
                                    color: neutral70, fontSize: 14),
                              ),
                              Text(
                                'Bacterial Leaf Blight',
                                style: mediumTS.copyWith(
                                    color: neutral100, fontSize: 18),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
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
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TabContentView(
                definisi: 'Hawar daun bakteri adalah penyakit yang disebabkan oleh bakteri Xanthomonas oryzae pv. oryzae, yang merupakan salah satu penyakit paling merusak pada tanaman padi. Penyakit ini menyerang daun, menyebabkan daun menjadi kuning, layu, dan akhirnya kering. Jika infeksi parah, tanaman dapat mati sebelum mencapai fase pematangan.', 
                gejala:  '1. Awalnya, muncul garis-garis atau bercak-bercak kecil berwarna hijau gelap pada tepi daun.\n2. Bercak tersebut kemudian membesar dan memanjang, berwarna coklat kekuningan, sehingga menyebabkan daun menjadi layu dan mati.\n3. Pada kondisi lembab, penyakit ini dapat menyebar dengan cepat, mengakibatkan kerusakan yang lebih parah.\n4. Pada infeksi berat, tanaman bisa mengalami kematian dini, yang sangat mempengaruhi hasil panen.', 
                solusi:  '1. Penggunaan Varietas Tahan\nMenanam varietas padi yang tahan terhadap Xanthomonas oryzae pv. oryzae merupakan salah satu cara yang efektif untuk mengurangi risiko serangan penyakit ini.\n2. Pengaturan Irigasi \nMenghindari genangan air yang berlebihan dan mengatur sistem irigasi dengan baik dapat membantu mengurangi penyebaran bakteri. Irigasi yang berlebihan dapat memperparah penyebaran penyakit ini.\n3. Rotasi Tanaman \nMelakukan rotasi tanaman dengan tanaman non- padi untuk memutus siklus hidup bakteri penyebab penyakit ini.\n4. Pengendalian Serangga Vektor \nMengendalikan serangga vektor yang bisa menyebarkan bakteri, seperti wereng hijau, juga penting dalam manajemen penyakit ini.\n5. Aplikasi Bakterisida \nJika serangan sudah terjadi, penggunaan bakterisida berbahan dasar tembaga (copper- based bactericides) dapat digunakan untuk mengurangi penyebaran infeksi. Namun, efektivitasnya terbatas dan harus digunakan sebagai upaya terakhir.',
              ), 
              const SizedBox(height: 20),
              Container(
                width: 286,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: neutral10,
                ),
                child: TabBar(
                  labelStyle: mediumTS.copyWith(
                      fontSize: 16, color: neutral10),
                  unselectedLabelStyle:
                      mediumTS.copyWith(fontSize: 16, color: neutral60),

                  indicator: BoxDecoration(
                    color: accentOrangeMain,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashBorderRadius: BorderRadius.circular(100),
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'Definisi'),
                    Tab(text: 'Gejala'),
                    Tab(text: 'Solusi'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            
            ],
          ),
        ),
      ),
    );
  }
}
