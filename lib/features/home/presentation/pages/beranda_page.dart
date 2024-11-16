import 'package:appwrite/models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_avatar.dart';
import '../../../../core/common/custom_empty_state.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../komunitas/presentation/cubit/komunitas/komunitas_cubit.dart';
import '../../../riwayat/presentation/widgets/riwayat_card.dart';
import '../../../user/presentation/cubit/user_cubit.dart';
import '../widgets/beranda_komunitas_card.dart';
import '../widgets/beranda_loading_card.dart';
import '../widgets/beranda_pindai_card.dart';

class BerandaPage extends StatefulWidget {
  final User user;
  final Function(int) updateIndex;
  const BerandaPage({super.key, required this.user, required this.updateIndex});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final carouselController = CarouselSliderController();
  int carouselIndex = 0;

  bool isRiwayatEmpty = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    context.read<UserCubit>().fetchUserModel(uid: widget.user.$id);
    context.read<KomunitasCubit>().fetchAllPosts(max: 3);
  }

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
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserFetched) {
                      return CustomAvatar(link: state.userModel.profilePicture);
                    }
                    return const CustomAvatar();
                  },
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
                      widget.user.name,
                      style: mediumTS.copyWith(fontSize: 18, color: neutral100),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () => fetchData(),
          child: ListView(
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
                        GestureDetector(
                          onTap: () => widget.updateIndex(2),
                          child: Text(
                            'Lihat semua',
                            style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<KomunitasCubit, KomunitasState>(
                    builder: (context, state) {
                      if (state is KomunitasLoading) {
                        return const BerandaLoadingCard();
                      } else if (state is KomunitasLoaded) {
                        return state.postModels.isNotEmpty
                            ? Column(
                                children: [
                                  CarouselSlider(
                                    carouselController: carouselController,
                                    items: state.postModels.map((post) {
                                      return BerandaKomunitasCard(
                                        user: widget.user,
                                        postModel: post,
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      height: 160,
                                      viewportFraction: 0.975,
                                      initialPage: carouselIndex,
                                      onPageChanged: (index, _) {
                                        setState(() => carouselIndex = index);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  DotsIndicator(
                                    dotsCount: state.postModels.length,
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
                            : const DiskusiEmptyState();
                      }
                      return const DiskusiEmptyState();
                    },
                  ),

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
                        GestureDetector(
                          onTap: () => widget.updateIndex(1),
                          child: Text(
                            'Lihat semua',
                            style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                          ),
                        ),
                      ],
                    ),
                  ),
                  !isRiwayatEmpty
                      ? Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            RiwayatCard(
                              image: 'assets/images/cardhist.jpeg',
                              title: 'Bacterial Leaf Blight',
                              timeAgo: '30 menit lalu',
                              onTap: () {},
                            ),
                            RiwayatCard(
                              image: 'assets/images/cardhist.jpeg',
                              title: 'Bacterial Leaf Blight',
                              timeAgo: '30 menit lalu',
                              onTap: () {},
                            ),
                            RiwayatCard(
                              image: 'assets/images/cardhist.jpeg',
                              title: 'Bacterial Leaf Blight',
                              timeAgo: '30 menit lalu',
                              onTap: () {},
                            ),
                            RiwayatCard(
                              image: 'assets/images/cardhist.jpeg',
                              title: 'Bacterial Leaf Blight',
                              timeAgo: '30 menit lalu',
                              onTap: () {},
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
      ),
    );
  }
}
