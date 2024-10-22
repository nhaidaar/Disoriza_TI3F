import 'package:disoriza/core/common/colors.dart';
import 'package:flutter/material.dart';

import 'package:disoriza/core/common/custom_tab_button.dart';
import 'package:disoriza/core/common/paddings.dart';
import 'package:disoriza/features/comunity/widgets/no_activity_layout.dart';
import 'package:disoriza/features/comunity/widgets/post_card.dart';


class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  // Menyimpan index tab yang terpilih
  int _selectedIndex = 0;
  bool isAnyActivity = true;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index; // Memperbarui index tab yang terpilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTabButton(
                    text: 'Semua',
                    onTabSelected: _onTabSelected,
                    selectedIndex: _selectedIndex,
                    tabIndex: 0, // Menetapkan tabIndex untuk tab ini
                  ),
                  CustomTabButton(
                    text: 'Postingan',
                    onTabSelected: _onTabSelected,
                    selectedIndex: _selectedIndex,
                    tabIndex: 1, // Menetapkan tabIndex untuk tab ini
                  ),
                  CustomTabButton(
                    text: 'Disukai',
                    onTabSelected: _onTabSelected,
                    selectedIndex: _selectedIndex,
                    tabIndex: 2, // Menetapkan tabIndex untuk tab ini
                  ),
                  CustomTabButton(
                    text: 'Komentar',
                    onTabSelected: _onTabSelected,
                    selectedIndex: _selectedIndex,
                    tabIndex: 3, // Menetapkan tabIndex untuk tab ini
                  ),
                ],
              ),
            ),
          ),
          isAnyActivity
              ? Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(xSmall),
                      child: _getTabContent(_selectedIndex)),
                )
              : const NoActivityLayout(),
        ],
      ),
    );
  }

  // Fungsi untuk mendapatkan konten berdasarkan tab yang dipilih
  Widget _getTabContent(int index) {
    switch (index) {
      case 0:
        // Menampilkan 3 PostCard yang bisa discroll
        return ListView.builder(
          itemCount: 3, // Menentukan jumlah PostCard yang ingin digenerate
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(
                  8.0), // Menambahkan padding antar PostCard
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: neutral10,
                ),
                width: double.infinity,
                child: const PostCard(), // Menampilkan PostCard
              ),
            );
          },
        );
      case 1:
        return const Text("Konten Postingan");
      case 2:
        return const Text("Konten Disukai");
      case 3:
        return const Text("Konten Komentar");
      default:
        return const Text("Konten Tidak Diketahui");
    }
  }
}
