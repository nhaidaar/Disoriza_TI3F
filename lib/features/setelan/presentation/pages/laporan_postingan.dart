import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/custom_empty_state.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../komunitas/presentation/blocs/komunitas_post/komunitas_post_bloc.dart';
import '../../../komunitas/presentation/widgets/post_card.dart';
import '../../../komunitas/presentation/widgets/reported_post_card.dart';

class LaporanPostingan extends StatefulWidget {
  final UserModel user;
  const LaporanPostingan({super.key, required this.user});

  @override
  State<LaporanPostingan> createState() => _LaporanPostinganState();
}

class _LaporanPostinganState extends State<LaporanPostingan> {
  @override
  void initState() {
    super.initState();
    fetchReportedPosts(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => fetchReportedPosts(context),
      child: BlocBuilder<KomunitasPostBloc, KomunitasPostState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(8),
            children: state is KomunitasPostLoading
                ? [
                    const PostLoadingCard(),
                  ]
                : state is KomunitasPostLoaded
                    ? state.postModels.isNotEmpty
                        ? state.postModels.map((post) {
                            return ReportedPostCard(user: widget.user, post: post);
                          }).toList()
                        : [
                            const DiskusiEmptyState(),
                          ]
                    : [
                        const DiskusiEmptyState(),
                      ],
          );
        },
      ),
    );
  }

  void fetchReportedPosts(BuildContext context) {
    context.read<KomunitasPostBloc>().add(KomunitasFetchReportedPosts());
  }
}
