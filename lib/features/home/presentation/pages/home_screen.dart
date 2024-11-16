import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import 'beranda_page.dart';
import '../../../riwayat/presentation/pages/riwayat_page.dart';
import '../../../komunitas/presentation/pages/komunitas_page.dart';
import '../../../setelan/presentation/pages/setelan_page.dart';

import '../../../komunitas/data/repositories/komunitas_repository_impl.dart';
import '../../../komunitas/domain/usecases/komunitas_usecase.dart';
import '../../../komunitas/presentation/cubit/comment/comment_cubit.dart';
import '../../../komunitas/presentation/cubit/komunitas/komunitas_cubit.dart';
import '../../../user/data/repositories/user_repository_impl.dart';
import '../../../user/domain/usecases/user_usecase.dart';
import '../../../user/presentation/cubit/user_cubit.dart';
import '../../../riwayat/data/repositories/riwayat_repository_impl.dart';
import '../../../riwayat/domain/usecases/riwayat_usecase.dart';
import '../../../riwayat/presentation/cubit/riwayat_cubit.dart';

class HomeScreen extends StatefulWidget {
  final Client client;
  final User user;
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
        BlocProvider(
          create: (context) => CommentCubit(
            KomunitasUsecase(KomunitasRepositoryImpl(client: widget.client)),
          ),
        ),
        BlocProvider(
          create: (context) => KomunitasCubit(
            KomunitasUsecase(KomunitasRepositoryImpl(client: widget.client)),
          ),
        ),
        BlocProvider(
          create: (context) => RiwayatCubit(
            RiwayatUsecase(RiwayatRepositoryImpl(client: widget.client)),
          ),
        ),
        BlocProvider(
          create: (context) => UserCubit(
            UserUsecase(UserRepositoryImpl(client: widget.client)),
          ),
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
                  onTap: () {},
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
