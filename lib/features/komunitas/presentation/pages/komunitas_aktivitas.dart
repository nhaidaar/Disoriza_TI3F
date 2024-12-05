import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/custom_empty_state.dart';
import '../../../auth/data/models/user_model.dart';
import '../blocs/komunitas_post/komunitas_post_bloc.dart';
import '../widgets/aktivitasmu_category.dart';
import '../widgets/post_card.dart';

class KomunitasAktivitas extends StatefulWidget {
  final UserModel user;
  const KomunitasAktivitas({super.key, required this.user});

  @override
  State<KomunitasAktivitas> createState() => _KomunitasAktivitasState();
}

class _KomunitasAktivitasState extends State<KomunitasAktivitas> {
  int _selectedIndex = 0;

  final aktivitasCategory = [
    'Postingan',
    'Disukai',
    'Komentar',
    'Dilaporkan',
  ];

  @override
  void initState() {
    super.initState();
    fetchAktivitas(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KomunitasPostBloc, KomunitasPostState>(
      listener: (context, state) {
        if (state is KomunitasPostDeleted) fetchAktivitas(context);
      },
      child: Column(
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
                        context.read<KomunitasPostBloc>().add(KomunitasFetchAktivitas(
                              uid: widget.user.id.toString(),
                              filter: aktivitasCategory[_selectedIndex],
                            ));
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
              onRefresh: () async => context.read<KomunitasPostBloc>().add(KomunitasFetchAktivitas(
                    uid: widget.user.id.toString(),
                    filter: aktivitasCategory[_selectedIndex],
                  )),
              displacement: 10,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  BlocBuilder<KomunitasPostBloc, KomunitasPostState>(
                    key: ObjectKey(_selectedIndex),
                    builder: (context, state) {
                      if (state is KomunitasPostLoading) {
                        return const PostLoadingCard();
                      } else if (state is KomunitasPostLoaded) {
                        return state.postModels.isNotEmpty
                            ? Column(
                                children: state.postModels.map((post) {
                                  return PostCard(
                                    user: widget.user,
                                    post: post,
                                    isAktivitas: true,
                                  );
                                }).toList(),
                              )
                            : const AktivitasEmptyState();
                      }
                      return const AktivitasEmptyState();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchAktivitas(BuildContext context) {
    context.read<KomunitasPostBloc>().add(KomunitasFetchAktivitas(
          uid: widget.user.id.toString(),
          filter: aktivitasCategory[_selectedIndex],
        ));
  }
}
