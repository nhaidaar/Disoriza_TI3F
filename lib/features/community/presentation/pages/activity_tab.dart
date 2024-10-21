import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/paddings.dart';
import 'package:flutter/material.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({super.key});

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  int _selectedIndex = 0; // Menyimpan index tab yang terpilih

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index; // Memperbarui index tab yang terpilih
    });
  }

  @override
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
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 4),
                    child: ElevatedButton(
                      onPressed: () => _onTabSelected(0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedIndex == 0 ? accentOrangeMain : neutral10,
                        foregroundColor:
                            _selectedIndex == 0 ? neutral10 : neutral60, // Warna background
                        padding: const EdgeInsets.symmetric(horizontal: xMedium),
                      ),
                      child: const Text('Semua'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () => _onTabSelected(1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedIndex == 1 ? accentOrangeMain : neutral10,
                        foregroundColor: _selectedIndex == 1 ? neutral10 : neutral60,
                        padding: const EdgeInsets.symmetric(horizontal: xMedium),
                      ),
                      child: const Text('Postingan'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () => _onTabSelected(2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedIndex == 2 ? accentOrangeMain : neutral10,
                        foregroundColor: _selectedIndex == 2 ? neutral10 : neutral60,
                        padding: const EdgeInsets.symmetric(horizontal: xMedium),
                      ),
                      child: const Text('Disukai'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 4, right: 8),
                    child: ElevatedButton(
                      onPressed: () => _onTabSelected(3),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedIndex == 3 ? accentOrangeMain : neutral10,
                        foregroundColor: _selectedIndex == 3 ? neutral10 : neutral60,
                        padding: const EdgeInsets.symmetric(horizontal: xMedium),
                      ),
                      child: const Text('Komentar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(small),
            child: Expanded(
              flex: 1,
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16), color: neutral10),
                  width: double.infinity,
                  child: _getTabContent(_selectedIndex)),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk mendapatkan konten berdasarkan tab yang dipilih
  Widget _getTabContent(int index) {
    switch (index) {
      case 0:
        return Text("Konten Semua");
      case 1:
        return Text("Konten Postingan");
      case 2:
        return Text("Konten Disukai");
      case 3:
        return Text("Konten Komentar");
      default:
        return Text("Konten Tidak Diketahui");
    }
  }
}
