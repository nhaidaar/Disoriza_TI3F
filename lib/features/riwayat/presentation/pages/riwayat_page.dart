import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/custom_empty_state.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';
import '../../../auth/data/models/user_model.dart';
import '../cubit/riwayat_cubit.dart';
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

    // Add a listener to update the search query on text change
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
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
            ),
          ],
        ),
      ),
      body: BlocBuilder<RiwayatCubit, RiwayatState>(
        builder: (context, state) {
          if (state is RiwayatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RiwayatLoaded) {
            // Filter the list based on the search query
            final filteredList = state.riwayatModel.where((riwayat) {
              final title = riwayat.idDisease?.name?.toLowerCase() ?? '';
              return title.contains(_searchQuery.toLowerCase());
            }).toList();

            if (filteredList.isEmpty) {
              return const Center(child: RiwayatEmptyState());
            }
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: filteredList.map((riwayat) {
                    return RiwayatCard(riwayatModel: riwayat);
                  }).toList(),
                ),
              ],
            );
          } else if (state is RiwayatError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: RiwayatEmptyState());
        },
      ),
    );
  }
}
