import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/common/colors.dart';
import '../../../../../core/common/fontstyles.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../auth/data/models/user_model.dart';
import '../blocs/komunitas_comment/komunitas_comment_bloc.dart';
import '../blocs/komunitas_post/komunitas_post_bloc.dart';
import '../blocs/komunitas_search/komunitas_search_bloc.dart';
import 'komunitas_aktivitas.dart';
import 'komunitas_diskusi.dart';
import 'search_post_page.dart';

class KomunitasPage extends StatelessWidget {
  final UserModel user;
  const KomunitasPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<KomunitasPostBloc, KomunitasPostState>(
          listener: (context, state) {
            if (state is KomunitasPostError) showSnackbar(context, message: state.message, isError: true);
          },
        ),
        BlocListener<KomunitasCommentBloc, KomunitasCommentState>(
          listener: (context, state) {
            if (state is KomunitasCommentError) showSnackbar(context, message: state.message, isError: true);
          },
        ),
        BlocListener<KomunitasSearchBloc, KomunitasSearchState>(
          listener: (context, state) {
            if (state is KomunitasSearchError) showSnackbar(context, message: state.message, isError: true);
          },
        ),
      ],
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      'Komunitas',
                      style: mediumTS.copyWith(color: neutral100),
                    ),

                    // Search Icon
                    IconButton(
                      onPressed: () => Navigator.of(context).push(
                        PageTransition(
                          child: BlocProvider.value(
                            value: context.read<KomunitasSearchBloc>(),
                            child: SearchPostPage(user: user),
                          ),
                          type: PageTransitionType.rightToLeft,
                        ),
                      ),
                      icon: const Icon(IconsaxPlusLinear.search_normal_1),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Diskusi dan Aktivitas (Tab Bar)
                Container(
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
                      Tab(text: 'Diskusi'),
                      Tab(text: 'Aktivitasmu'),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              KomunitasDiskusi(user: user),
              KomunitasAktivitas(user: user),
            ],
          ),
        ),
      ),
    );
  }
}
