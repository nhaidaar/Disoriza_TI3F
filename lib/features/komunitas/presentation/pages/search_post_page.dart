import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_empty_state.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../auth/data/models/user_model.dart';
import '../blocs/komunitas_search/komunitas_search_bloc.dart';
import '../widgets/post_card.dart';

class SearchPostPage extends StatefulWidget {
  final UserModel user;
  const SearchPostPage({super.key, required this.user});

  @override
  State<SearchPostPage> createState() => _SearchPostPageState();
}

class _SearchPostPageState extends State<SearchPostPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutral10,
        surfaceTintColor: neutral10,
        toolbarHeight: 128,
        shape: const Border(
          bottom: BorderSide(color: neutral30),
        ),

        // Back Button
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(IconsaxPlusLinear.arrow_left),
        ),

        title: Text(
          'Cari diskusi',
          style: mediumTS.copyWith(fontSize: 16, color: neutral100),
        ),
        centerTitle: true,

        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: CustomFormField(
              controller: _searchController,
              hint: 'Cari judul penyakit',
              backgroundColor: backgroundCanvas,
              prefixIcon: IconsaxPlusLinear.search_normal,
              prefixIconColor: neutral60,
              onChanged: (value) {
                Timer(const Duration(seconds: 2), () {
                  setState(() => context.read<KomunitasSearchBloc>().add(KomunitasSearchPost(search: value)));
                });
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<KomunitasSearchBloc, KomunitasSearchState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(8),
            children: state is KomunitasSearchLoading
                ? [
                    const PostLoadingCard(),
                  ]
                : state is KomunitasSearchLoaded
                    ? state.postModels.isNotEmpty
                        ? state.postModels.map((post) {
                            return PostCard(user: widget.user, post: post);
                          }).toList()
                        : [
                            const DiskusiEmptyState(),
                          ]
                    : [],
          );
        },
      ),
    );
  }
}
