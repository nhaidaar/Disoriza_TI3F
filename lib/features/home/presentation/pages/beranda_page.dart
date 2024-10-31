import 'package:appwrite/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:disoriza/core/common/custom_empty_state.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../riwayat/presentation/widgets/riwayat_card.dart';
import '../../../user/presentation/cubit/user_cubit.dart';
import '../widgets/beranda_komunitas_card.dart';
import '../widgets/beranda_pindai_card.dart';

class BerandaPage extends StatefulWidget {
  final User user;
  const BerandaPage({super.key, required this.user});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final carouselController = CarouselSliderController();
  final carouselItems = const [
    BerandaKomunitasCard(),
    BerandaKomunitasCard(),
    BerandaKomunitasCard(),
  ];
  int carouselIndex = 0;

  bool isDiskusiEmpty = false;
  bool isRiwayatEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            toolbarHeight: 70,
            backgroundColor: backgroundCanvas,
            surfaceTintColor: backgroundCanvas,
            title: Row(
              children: [
                // Avatar
                BlocProvider(
                  create: (context) => BlocProvider.of<UserCubit>(context)
                    ..fetchUserModel(
                      uid: widget.user.$id,
                    ),
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserFetched && state.userModel.profilePicture != null) {
                        return CircleAvatar(
                          radius: 20,
                          backgroundColor: neutral10,
                          backgroundImage: CachedNetworkImageProvider(
                            state.userModel.profilePicture.toString(),
                          ),
                        );
                      }
                      return const CircleAvatar(
                        radius: 20,
                        backgroundColor: neutral10,
                        child: Icon(IconsaxPlusLinear.profile, color: neutral100),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 8),

                // Greeting Message
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang, ',
                      style: regularTS.copyWith(fontSize: 14, color: neutral100),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Naufal Haidar',
                      style: mediumTS.copyWith(fontSize: 18, color: neutral100),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Pindai dengan Disoriza AI
            BerandaPindaiCard(
              onTap: () => showDialog(
                context: context,
                builder: (context) => const CustomPopup(
                  icon: IconsaxPlusBold.flash_1,
                  iconColor: successMain,
                  title: 'Sedang memproses',
                  subtitle: 'Sabar ya, gambar sedang diproses.',
                  isLoading: true,
                ),
              ),
            ),

            // Diskusi & Riwayat
            Column(
              children: [
                // Diskusi petani
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: Row(
                    children: [
                      Text(
                        'Diskusi petani',
                        style: mediumTS.copyWith(fontSize: 18, color: neutral100),
                      ),
                      const Spacer(),
                      Text(
                        'Lihat semua',
                        style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                      ),
                    ],
                  ),
                ),
                !isDiskusiEmpty
                    ? Column(
                        children: [
                          CarouselSlider(
                            carouselController: carouselController,
                            items: carouselItems,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              aspectRatio:
                                  MediaQuery.of(context).orientation == Orientation.portrait
                                      ? 2
                                      : 4,
                              viewportFraction: 0.975,
                              initialPage: carouselIndex,
                              onPageChanged: (index, _) {
                                setState(() => carouselIndex = index);
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          DotsIndicator(
                            dotsCount: 3,
                            position: carouselIndex,
                            decorator: const DotsDecorator(
                              spacing: EdgeInsets.all(4),
                              color: neutral50,
                              activeColor: accentGreenMain,
                            ),
                            onTap: (index) {
                              carouselController.animateToPage(index);
                            },
                          ),
                        ],
                      )
                    : const DiskusiEmptyState(),

                // Riwayat Scan
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Row(
                    children: [
                      Text(
                        'Riwayat terbaru',
                        style: mediumTS.copyWith(fontSize: 18, color: neutral100),
                      ),
                      const Spacer(),
                      Text(
                        'Lihat semua',
                        style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                      ),
                    ],
                  ),
                ),
                !isRiwayatEmpty
                    ? const Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          RiwayatCard(
                            image: 'assets/images/cardhist.jpeg',
                            title: 'Bacterial Leaf Blight',
                            timeAgo: '30 menit lalu',
                          ),
                          RiwayatCard(
                            image: 'assets/images/cardhist.jpeg',
                            title: 'Bacterial Leaf Blight',
                            timeAgo: '30 menit lalu',
                          ),
                          RiwayatCard(
                            image: 'assets/images/cardhist.jpeg',
                            title: 'Bacterial Leaf Blight',
                            timeAgo: '30 menit lalu',
                          ),
                          RiwayatCard(
                            image: 'assets/images/cardhist.jpeg',
                            title: 'Bacterial Leaf Blight',
                            timeAgo: '30 menit lalu',
                          ),
                        ],
                      )
                    : const RiwayatEmptyState(),

                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
