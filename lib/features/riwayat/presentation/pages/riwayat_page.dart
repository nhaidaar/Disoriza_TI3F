import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/custom_empty_state.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';
import '../../../auth/data/models/user_model.dart';
import '../cubit/riwayat/riwayat_cubit.dart';
import '../widgets/riwayat_card.dart';

class RiwayatPage extends StatefulWidget {
  final UserModel user;
  const RiwayatPage({super.key, required this.user});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<RiwayatCubit>().fetchAllRiwayat(uid: widget.user.id.toString());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              'Riwayat pemindaian',
              style: mediumTS.copyWith(color: neutral100),
            ),
            const SizedBox(height: 16),
            CustomFormField(
              controller: _searchController,
              hint: 'Cari judul penyakit',
              backgroundColor: backgroundCanvas,
              prefixIcon: IconsaxPlusLinear.search_normal,
              prefixIconColor: neutral60,
              onChanged: (value) {
                Timer(Durations.extralong1, () {
                  setState(() => _searchQuery = _searchController.text);
                });
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<RiwayatCubit>().fetchAllRiwayat(uid: widget.user.id.toString());
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            BlocBuilder<RiwayatCubit, RiwayatState>(
              builder: (context, state) {
                if (state is RiwayatLoading) {
                  return const RiwayatLoadingCard();
                } else if (state is RiwayatLoaded) {
                  // Filter by search
                  final filteredList = state.riwayatModel.where((riwayat) {
                    final title = riwayat.idDisease?.name?.toLowerCase() ?? '';
                    return title.contains(_searchQuery.toLowerCase());
                  }).toList();

                  if (filteredList.isNotEmpty) {
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: filteredList.map((riwayat) {
                        return RiwayatCard(riwayatModel: riwayat);
                      }).toList(),
                    );
                  }
                  return const Center(child: RiwayatEmptyState());
                }
                return const Center(child: RiwayatEmptyState());
              },
            ),
          ],
        ),
      ),
    );
  }
}
