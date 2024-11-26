// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/utils/camera.dart';
import '../../../../core/utils/dialog.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../riwayat/presentation/blocs/riwayat_history/riwayat_history_bloc.dart';
import '../../../riwayat/presentation/blocs/riwayat_scan/riwayat_scan_bloc.dart';
import '../../../riwayat/presentation/pages/riwayat_detail.dart';
import '../../../riwayat/presentation/pages/riwayat_page.dart';
import '../../../komunitas/presentation/pages/komunitas_page.dart';
import '../../../setelan/presentation/pages/setelan_page.dart';
import 'beranda_page.dart';

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

  void fetchRiwayats(BuildContext context) {
    context.read<RiwayatHistoryBloc>().add(RiwayatFetchRiwayats(
          uid: widget.user.id.toString(),
          max: _selectedIndex == 0 ? 4 : null,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      BerandaPage(user: widget.user, updateIndex: updateIndex),
      RiwayatPage(user: widget.user),
      KomunitasPage(user: widget.user),
      SetelanPage(user: widget.user),
    ];

    return MultiBlocListener(
      listeners: [
        BlocListener<RiwayatHistoryBloc, RiwayatHistoryState>(
          listener: (context, state) {
            if (state is RiwayatHistoryError) handleDiseaseError(context);

            if (state is RiwayatHistoryDeleted) handleRiwayatDeleted(context);
          },
        ),
        BlocListener<RiwayatScanBloc, RiwayatScanState>(
          listener: (context, state) {
            if (state is RiwayatScanError) handleDiseaseError(context);

            if (state is RiwayatScanLoading) showDiseaseLoading(context);

            if (state is RiwayatScanSuccess) handleDiseaseSuccess(context, state);
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
                  onTap: () async => await handleScanDisease(context),
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

  void handleRiwayatDeleted(BuildContext context) {
    // Pop confirmation popup
    Navigator.of(context).pop();

    // Pop detail page
    Navigator.of(context).pop();

    showSnackbar(context, message: 'Riwayat berhasil dihapus');

    // Fetch new Riwayat
    fetchRiwayats(context);
  }

  void handleDiseaseSuccess(BuildContext context, RiwayatScanSuccess state) {
    // Pop loading popup
    Navigator.of(context).pop();

    // Return the model (although sakit/sehat)
    state.riwayatModel != null
        ? Navigator.of(context)
            .push(
              PageTransition(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: context.read<RiwayatHistoryBloc>(),
                    ),
                    BlocProvider.value(
                      value: context.read<RiwayatScanBloc>(),
                    ),
                  ],
                  child: RiwayatDetail(riwayat: state.riwayatModel!),
                ),
                type: PageTransitionType.rightToLeft,
              ),
            )
            .then((_) => fetchRiwayats(context))
        : showDiseaseSehat(
            context,
            onScan: () {
              // Pop sehat popup
              Navigator.of(context).pop();

              handleScanDisease(context);
            },
          );
  }

  void handleDiseaseError(BuildContext context) {
    // Pop loading popup
    Navigator.of(context).pop();

    showDiseaseError(
      context,
      onScan: () {
        // Pop error popup
        Navigator.of(context).pop();

        handleScanDisease(context);
      },
    );
  }

  Future<void> handleScanDisease(BuildContext context) async {
    final img = await pickImage(context);
    if (img != null) {
      context.read<RiwayatScanBloc>().add(RiwayatScanDisease(
            uid: widget.user.id.toString(),
            image: img,
          ));
    }
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
