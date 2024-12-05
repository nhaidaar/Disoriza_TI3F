import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/custom_empty_state.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../komunitas/presentation/blocs/komunitas_comment/komunitas_comment_bloc.dart';
import '../../../komunitas/presentation/blocs/komunitas_post/komunitas_post_bloc.dart';
import '../../../komunitas/presentation/widgets/post_card.dart';
import '../../../komunitas/presentation/widgets/reported_comment_card.dart';

class LaporanKomentar extends StatefulWidget {
  final UserModel user;
  const LaporanKomentar({super.key, required this.user});

  @override
  State<LaporanKomentar> createState() => _LaporanKomentarState();
}

class _LaporanKomentarState extends State<LaporanKomentar> {
  @override
  void initState() {
    super.initState();
    fetchReportedComments(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<KomunitasCommentBloc, KomunitasCommentState>(
          listener: (context, state) {
            if (state is KomunitasCommentDeleted) fetchReportedComments(context);
          },
        ),
        BlocListener<KomunitasPostBloc, KomunitasPostState>(
          listener: (context, state) {
            if (state is KomunitasPostDeleted) fetchReportedComments(context);
          },
        ),
      ],
      child: RefreshIndicator(
        onRefresh: () async => fetchReportedComments(context),
        child: BlocBuilder<KomunitasPostBloc, KomunitasPostState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(8),
              children: state is KomunitasPostLoading
                  ? [
                      const PostLoadingCard(),
                    ]
                  : state is KomunitasPostWithCommentLoaded
                      ? state.commentWithPost.isNotEmpty
                          ? state.commentWithPost.map((model) {
                              return ReportedCommentCard(
                                user: widget.user,
                                comment: model.commentModel,
                                post: model.postModel,
                              );
                            }).toList()
                          : [
                              const KomentarEmptyState(),
                            ]
                      : [
                          const KomentarEmptyState(),
                        ],
            );
          },
        ),
      ),
    );
  }

  void fetchReportedComments(BuildContext context) {
    context.read<KomunitasPostBloc>().add(KomunitasFetchReportedComments());
  }
}
