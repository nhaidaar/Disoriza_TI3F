import 'package:flutter/material.dart';

import '../../../../core/common/custom_empty_state.dart';
import '../widgets/aktivitasmu_category.dart';
import '../widgets/post_card.dart';

class AktivitasmuPage extends StatefulWidget {
  const AktivitasmuPage({super.key});

  @override
  State<AktivitasmuPage> createState() => _AktivitasmuPageState();
}

class _AktivitasmuPageState extends State<AktivitasmuPage> {
  int _selectedIndex = 0;

  final aktivitasCategory = [
    'Semua',
    'Postingan',
    'Disukai',
    'Komentar',
    'Lorem Ipsum Dolor Sit Amet',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            // Choose a category
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: aktivitasCategory.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 8 : 0,
                      right: index == aktivitasCategory.length - 1 ? 4 : 0,
                    ),
                    child: AktivitasmuCategory(
                      onTap: () => setState(() {
                        if (_selectedIndex != index) _selectedIndex = index;
                      }),
                      title: aktivitasCategory[index],
                      isSelected: _selectedIndex == index,
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                key: ObjectKey(_selectedIndex),
                children: [
                  _selectedIndex % 2 == 0
                      ? AktivitasEmptyState(title: aktivitasCategory[_selectedIndex])
                      : PostCard(
                          title: 'Test Filter ${aktivitasCategory[_selectedIndex]}',
                          text:
                              'Ullamco nulla tempor ex id ad laborum eu est nisi reprehenderit adipisicing aliqua enim.',
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
