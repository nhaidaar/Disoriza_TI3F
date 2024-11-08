import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/custom_dropdown.dart';
import '../../../../core/common/custom_empty_state.dart';
import '../cubit/komunitas/komunitas_cubit.dart';
import '../widgets/create_post_button.dart';
import '../widgets/post_loading_card.dart';
import '../widgets/post_card.dart';

class DiskusiPage extends StatefulWidget {
  final User user;
  const DiskusiPage({super.key, required this.user});

  @override
  State<DiskusiPage> createState() => _DiskusiPageState();
}

class _DiskusiPageState extends State<DiskusiPage> {
  bool isLatest = false;

  @override
  void initState() {
    context.read<KomunitasCubit>().fetchAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      edgeOffset: 75,
      onRefresh: () async {
        await context.read<KomunitasCubit>().fetchAllPosts(latest: isLatest);
      },
      child: ListView(
        children: [
          // Create Post Widget
          CreatePostButton(user: widget.user),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                // Filter post
                Row(
                  children: [
                    CustomDropdown(
                      items: const [
                        MapEntry('Terpopuler', false),
                        MapEntry('Terbaru', true),
                      ],
                      initialValue: const MapEntry('Terpopuler', false),
                      onChanged: (filter) {
                        if (isLatest != filter.value) {
                          isLatest = !isLatest;
                          context.read<KomunitasCubit>().fetchAllPosts(latest: isLatest);
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                BlocBuilder<KomunitasCubit, KomunitasState>(
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
                                );
                              }).toList(), // Don't forget .toList()
                            )
                          : const DiskusiEmptyState();
                    }
                    return const DiskusiEmptyState();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
