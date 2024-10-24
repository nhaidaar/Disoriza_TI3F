import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/paddings.dart';
import 'package:disoriza/core/common/custom_tab_button.dart';
import 'package:disoriza/features/community/presentation/widgets/no_activity_layout.dart';
import 'package:disoriza/features/community/presentation/widgets/post_card.dart';
import 'package:disoriza/features/community/presentation/model/discussion_item.dart';

import 'package:flutter/material.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({super.key});

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  // Menyimpan index tab yang terpilih
  int _selectedIndex = 0;
  bool isAnyActivity = true;

  final List<PostItemCard> PItems = [
    PostItemCard(
      author: 'Ihza Nurkhafidh',
      timeAgo: '12 hours ago',
      title: 'Cara mendapatkan pestisida',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the ...',
      likes: 12,
      commands: 12,
      imageUrl: '',
    ),
    PostItemCard(
      author: 'Ihza Nurkhafidh',
      timeAgo: '12 hours ago',
      title: 'Cara mendapatkan pestisida',
      content:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the ...',
      likes: 12,
      commands: 12,
      imageUrl: '/assets/images/background.png',
    ),
  ];

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
          itemCount:
              PItems.length, // Menentukan jumlah PostCard yang ingin digenerate
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: backgroundCanvas,
              ),
              width: double.infinity,
              child: PostCard(
                showText: true,
                postcard: PItems[index],
              ), // Menampilkan PostCard
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
