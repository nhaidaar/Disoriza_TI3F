import 'package:disoriza/features/riwayat/presentation/pages/riwayat_detail.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/riwayat_card.dart';
import '../../../../core/common/custom_empty_state.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';
import '../cubit/riwayat_cubit.dart';

class RiwayatPage extends StatefulWidget {
  final User user;
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
    context.read<RiwayatCubit>().fetchAllRiwayat(user: widget.user);

    // Add a listener to update the search query on text change
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
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
      body: BlocListener<RiwayatCubit, RiwayatState>(
        listener: (context, state) {
                if (state is RiwayatDiseaseLoaded) {
                            Navigator.of(context).push(
                              PageTransition(
                                child: RiwayatDetail(
                                  user: widget.user,
                                  riwayat: state.diseaseModel,
                                  image: 'assets/images/cardhist.jpeg',
                                  title: state.diseaseModel.id_disease!.name.toString(),
                                ),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          }
        },
        child: BlocBuilder<RiwayatCubit, RiwayatState>(
          builder: (context, state) {
            if (state is RiwayatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RiwayatLoaded) {
              // Filter the list based on the search query
              final filteredList = state.histModels.where((riwayat) {
                final title = riwayat.id_disease?.name?.toLowerCase() ?? '';
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
                      return RiwayatCard(
                        // id: riwayat.id_disease?.id ?? '',
                        image: 'assets/images/cardhist.jpeg',
                        title: riwayat.id_disease?.name ?? 'Unknown Disease',
                        timeAgo: 'Some time ago',
                        onTap: () {
                          context.read<RiwayatCubit>().fetchDisease(
                              id_disease: riwayat.id_disease?.id ?? '');
                        },
                      );
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
      ),
    );
  }
}
