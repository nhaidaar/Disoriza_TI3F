// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_avatar.dart';
import '../../../../core/common/custom_empty_state.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/utils/camera.dart';
import '../../../komunitas/presentation/cubit/post/post_cubit.dart';
import '../../../riwayat/presentation/cubit/disease/disease_cubit.dart';
import '../../../riwayat/presentation/cubit/riwayat/riwayat_cubit.dart';
import '../../../riwayat/presentation/widgets/riwayat_card.dart';
import '../../../auth/data/models/user_model.dart';
import '../widgets/beranda_komunitas_card.dart';
import '../widgets/beranda_loading_card.dart';
import '../widgets/beranda_pindai_card.dart';

class BerandaPage extends StatefulWidget {
  final UserModel user;
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
    context.read<PostCubit>().fetchAllPosts(max: 3);
    context.read<RiwayatCubit>().fetchAllRiwayat(uid: widget.user.id.toString(), max: 4);
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
                GestureDetector(
                  onTap: () => widget.updateIndex(3),
                  child: CustomAvatar(link: widget.user.profilePicture),
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
                      widget.user.name.toString(),
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
                onTap: () async {
                  final img = await pickImage(ImageSource.camera);
                  if (img != null) {
                    context.read<DiseaseCubit>().scanDisease(
                          uid: widget.user.id.toString(),
                          image: img,
                        );
                  }
                },
              ),

              // Diskusi & Riwayat
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  BlocBuilder<PostCubit, PostState>(
                    builder: (context, state) {
                      if (state is PostLoading) {
                        return const BerandaLoadingCard();
                      } else if (state is PostLoaded) {
                        return state.postModels.isNotEmpty
                            ? Column(
                                children: [
                                  CarouselSlider(
                                    carouselController: carouselController,
                                    items: state.postModels.map((post) {
                                      return BerandaKomunitasCard(
                                        uid: widget.user.id.toString(),
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
                  BlocBuilder<RiwayatCubit, RiwayatState>(
                    builder: (context, state) {
                      if (state is RiwayatLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: RiwayatLoadingCard(),
                        );
                      } else if (state is RiwayatLoaded) {
                        return state.riwayatModel.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: state.riwayatModel.map((riwayat) {
                                    return RiwayatCard(riwayatModel: riwayat);
                                  }).toList(),
                                ),
                              )
                            : const RiwayatEmptyState();
                      }

                      return const RiwayatEmptyState();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
