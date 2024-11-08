import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/custom_empty_state.dart';
import '../cubit/komunitas/komunitas_cubit.dart';
import '../widgets/aktivitasmu_category.dart';
import '../widgets/post_card.dart';
import '../widgets/post_loading_card.dart';

class AktivitasmuPage extends StatefulWidget {
  final User user;
  const AktivitasmuPage({super.key, required this.user});

  @override
  State<AktivitasmuPage> createState() => _AktivitasmuPageState();
}

class _AktivitasmuPageState extends State<AktivitasmuPage> {
  int _selectedIndex = 0;

  final aktivitasCategory = [
    'Semua',
    'Postingan',
    'Disukai',
    'Komentar',
  ];

  @override
  void initState() {
    context.read<KomunitasCubit>().fetchAktivitas(
          user: widget.user,
          filter: aktivitasCategory[_selectedIndex],
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),

        // Choose a category
        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: aktivitasCategory.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 8 : 0,
                  right: index == aktivitasCategory.length - 1 ? 4 : 0,
                ),
                child: AktivitasmuCategory(
                  onTap: () => setState(() {
                    if (_selectedIndex != index) {
                      _selectedIndex = index;
                      context.read<KomunitasCubit>().fetchAktivitas(
                            user: widget.user,
                            filter: aktivitasCategory[_selectedIndex],
                          );
                    }
                  }),
                  title: aktivitasCategory[index],
                  isSelected: _selectedIndex == index,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<KomunitasCubit>().fetchAktivitas(
                    user: widget.user,
                    filter: aktivitasCategory[_selectedIndex],
                  );
            },
            displacement: 10,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                BlocBuilder<KomunitasCubit, KomunitasState>(
                  key: ObjectKey(_selectedIndex),
                  builder: (context, state) {
                    if (state is KomunitasLoading) {
                      return const PostLoadingCard();
                    } else if (state is KomunitasLoaded) {
                      return state.postModels.isNotEmpty
                          ? Column(
                              children: state.postModels.map((post) {
                                return PostCard(
                                  user: widget.user,
                                  postModel: post,
                                  isAktivitas: true,
                                );
                              }).toList(),
                            )
                          : AktivitasEmptyState(
                              title: aktivitasCategory[_selectedIndex],
                            );
                    }
                    return AktivitasEmptyState(
                      title: aktivitasCategory[_selectedIndex],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
