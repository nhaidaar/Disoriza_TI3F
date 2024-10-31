import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';

import 'beranda_page.dart';
import '../../../riwayat/presentation/pages/riwayat_page.dart';
import '../../../komunitas/presentation/pages/komunitas_page.dart';
import '../../../setelan/presentation/pages/setelan_page.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final pages = [
    const BerandaPage(),
    const RiwayatPage(),
    const KomunitasPage(),
    const SetelanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Select pages by index
      body: pages[selectedIndex],

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
              selected: selectedIndex == 0,
              onTap: () {
                if (selectedIndex != 0) setState(() => selectedIndex = 0);
              },
            ),

            // Riwayat
            NavItem(
              icon: IconsaxPlusLinear.clipboard_text,
              activeIcon: IconsaxPlusBold.clipboard_text,
              title: 'Riwayat',
              selected: selectedIndex == 1,
              onTap: () {
                if (selectedIndex != 1) setState(() => selectedIndex = 1);
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
              selected: selectedIndex == 2,
              onTap: () {
                if (selectedIndex != 2) setState(() => selectedIndex = 2);
              },
            ),

            // Setelan
            NavItem(
              icon: IconsaxPlusLinear.setting,
              activeIcon: IconsaxPlusBold.setting,
              title: 'Setelan',
              selected: selectedIndex == 3,
              onTap: () {
                if (selectedIndex != 3) setState(() => selectedIndex = 3);
              },
            ),
          ],
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
