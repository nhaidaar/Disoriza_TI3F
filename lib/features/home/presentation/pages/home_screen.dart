// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';

import '../../../../core/utils/camera.dart';
import '../../../../core/utils/loading_dialog.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../riwayat/presentation/cubit/disease/disease_cubit.dart';
import '../../../riwayat/presentation/pages/riwayat_detail.dart';
import 'beranda_page.dart';
import '../../../riwayat/presentation/pages/riwayat_page.dart';
import '../../../komunitas/presentation/pages/komunitas_page.dart';
import '../../../setelan/presentation/pages/setelan_page.dart';

import '../../../komunitas/presentation/cubit/comment/comment_cubit.dart';
import '../../../komunitas/presentation/cubit/post/post_cubit.dart';
import '../../../riwayat/presentation/cubit/riwayat/riwayat_cubit.dart';

class HomeScreen extends StatefulWidget {
  final SupabaseClient client;
  final UserModel user;
  const HomeScreen({super.key, required this.client, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void updateIndex(int newIndex) {
    setState(() => _selectedIndex = newIndex);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      BerandaPage(user: widget.user, updateIndex: updateIndex),
      RiwayatPage(user: widget.user),
      KomunitasPage(user: widget.user),
      const SetelanPage(),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: context.read<AuthCubit>(),
        ),
        BlocProvider.value(
          value: context.read<CommentCubit>(),
        ),
        BlocProvider.value(
          value: context.read<PostCubit>(),
        ),
        BlocProvider.value(
          value: context.read<DiseaseCubit>(),
        ),
        BlocProvider.value(
          value: context.read<RiwayatCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CommentCubit, CommentState>(
            listener: (context, state) {
              if (state is CommentError) showSnackbar(context, message: state.message, isError: true);
            },
          ),
          BlocListener<PostCubit, PostState>(
            listener: (context, state) {
              if (state is PostError) showSnackbar(context, message: state.message, isError: true);
            },
          ),
          BlocListener<DiseaseCubit, DiseaseState>(
            listener: (context, state) {
              if (state is DiseaseLoading) showDiseaseLoading(context);

              if (state is DiseaseError) {
                Navigator.of(context).pop();

                showSnackbar(context, message: state.message, isError: true);
              }

              if (state is DiseaseSuccess) {
                Navigator.of(context).pop();

                Navigator.of(context).push(
                  PageTransition(
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: context.read<RiwayatCubit>(),
                        ),
                        BlocProvider.value(
                          value: context.read<DiseaseCubit>(),
                        ),
                      ],
                      child: RiwayatDetail(riwayat: state.riwayatModel),
                    ),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              }
            },
          ),
          BlocListener<RiwayatCubit, RiwayatState>(
            listener: (context, state) {
              if (state is RiwayatError) showSnackbar(context, message: state.message, isError: true);

              if (state is RiwayatDeleted) {
                Navigator.of(context).pop();

                showSnackbar(context, message: 'Riwayat berhasil dihapus');

                context.read<RiwayatCubit>().fetchAllRiwayat(uid: widget.user.id.toString());
              }
            },
          ),
        ],
        child: Scaffold(
          // Select pages by index
          body: pages[_selectedIndex],

          bottomNavigationBar: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: neutral10,
              border: Border(top: BorderSide(color: neutral30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Beranda
                NavItem(
                  icon: IconsaxPlusLinear.home_2,
                  activeIcon: IconsaxPlusBold.home_2,
                  title: 'Beranda',
                  selected: _selectedIndex == 0,
                  onTap: () {
                    if (_selectedIndex != 0) updateIndex(0);
                  },
                ),

                // Riwayat
                NavItem(
                  icon: IconsaxPlusLinear.clipboard_text,
                  activeIcon: IconsaxPlusBold.clipboard_text,
                  title: 'Riwayat',
                  selected: _selectedIndex == 1,
                  onTap: () {
                    if (_selectedIndex != 1) updateIndex(1);
                  },
                ),

                // Scan
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GestureDetector(
                    onTap: () async {
                      final img = await pickImage(ImageSource.camera);
                      if (img != null) {
                        context.read<DiseaseCubit>().scanDisease(
                              uid: widget.user.id.toString(),
                              image: img,
                            );
                      }
                    },
                    child: const CircleAvatar(
                      radius: 26,
                      backgroundColor: accentOrangeMain,
                      child: Icon(IconsaxPlusBold.scan, color: neutral10),
                    ),
                  ),
                ),

                // Komunitas
                NavItem(
                  icon: IconsaxPlusLinear.story,
                  activeIcon: IconsaxPlusBold.story,
                  title: 'Komunitas',
                  selected: _selectedIndex == 2,
                  onTap: () {
                    if (_selectedIndex != 2) updateIndex(2);
                  },
                ),

                // Setelan
                NavItem(
                  icon: IconsaxPlusLinear.setting,
                  activeIcon: IconsaxPlusBold.setting,
                  title: 'Setelan',
                  selected: _selectedIndex == 3,
                  onTap: () {
                    if (_selectedIndex != 3) updateIndex(3);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool selected;
  final String title;
  final Function()? onTap;
  const NavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.selected,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 6),
            Icon(
              selected ? activeIcon : icon,
              color: selected ? accentGreenMain : neutral70,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: mediumTS.copyWith(
                fontSize: 12,
                color: selected ? accentGreenMain : neutral70,
              ),
            )
          ],
        ),
      ),
    );
  }
}
