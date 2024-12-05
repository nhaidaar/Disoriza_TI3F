import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../komunitas/presentation/blocs/komunitas_post/komunitas_post_bloc.dart';
import 'laporan_komentar.dart';
import 'laporan_postingan.dart';

class LaporanPage extends StatelessWidget {
  final UserModel user;
  const LaporanPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocListener<KomunitasPostBloc, KomunitasPostState>(
      listener: (context, state) {
        if (state is KomunitasPostError) showSnackbar(context, message: state.message, isError: true);

        if (state is KomunitasPostDeleted) {
          Navigator.of(context).pop(); // Pop the confirmation popup
          Navigator.of(context).pop(); // Pop the detail post page
          showSnackbar(context, message: 'Postingan berhasil dihapus!');
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 128,
            backgroundColor: neutral10,
            surfaceTintColor: neutral10,
            shape: const Border(
              bottom: BorderSide(color: neutral30),
            ),

            // Back Button
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(IconsaxPlusLinear.arrow_left),
            ),

            // Title
            title: Text(
              'Laporan',
              style: mediumTS.copyWith(color: neutral100),
            ),
            centerTitle: true,

            bottom: PreferredSize(
              preferredSize: Size.zero,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: backgroundCanvas,
                ),
                child: TabBar(
                  labelStyle: mediumTS.copyWith(fontSize: 16, color: accentGreenMain),
                  unselectedLabelStyle: mediumTS.copyWith(fontSize: 16, color: neutral60),
                  indicator: BoxDecoration(
                    color: neutral10,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashBorderRadius: BorderRadius.circular(100),
                  dividerHeight: 0,
                  tabs: const [
                    Tab(text: 'Postingan'),
                    Tab(text: 'Komentar'),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              LaporanPostingan(user: user),
              LaporanKomentar(user: user),
            ],
          ),
        ),
      ),
    );
  }
}
