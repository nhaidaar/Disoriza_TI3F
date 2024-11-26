import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/custom_dropdown.dart';
import '../../../../core/common/custom_empty_state.dart';
import '../../../auth/data/models/user_model.dart';
import '../blocs/komunitas_post/komunitas_post_bloc.dart';
import '../widgets/create_post_button.dart';
import '../widgets/post_card.dart';

class KomunitasDiskusi extends StatefulWidget {
  final UserModel user;
  const KomunitasDiskusi({super.key, required this.user});

  @override
  State<KomunitasDiskusi> createState() => _KomunitasDiskusiState();
}

class _KomunitasDiskusiState extends State<KomunitasDiskusi> {
  bool isLatest = false;

  @override
  void initState() {
    context.read<KomunitasPostBloc>().add(const KomunitasFetchPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      edgeOffset: 75,
      onRefresh: () async => context.read<KomunitasPostBloc>().add(KomunitasFetchPosts(latest: isLatest)),
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
                          context.read<KomunitasPostBloc>().add(KomunitasFetchPosts(latest: isLatest));
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                BlocBuilder<KomunitasPostBloc, KomunitasPostState>(
                  builder: (context, state) {
                    if (state is KomunitasPostLoading) {
                      return const PostLoadingCard();
                    } else if (state is KomunitasPostLoaded) {
                      return state.postModels.isNotEmpty
                          ? Column(
                              children: state.postModels.map((post) {
                                return PostCard(
                                  uid: widget.user.id.toString(),
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
