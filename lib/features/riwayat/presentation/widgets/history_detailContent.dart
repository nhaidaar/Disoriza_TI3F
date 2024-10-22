import 'package:flutter/material.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';

class TabContentView extends StatelessWidget {
  final String definisi;
  final String gejala;
  final String solusi;

  const TabContentView({
    Key? key,
    required this.definisi,
    required this.gejala,
    required this.solusi,
  }) : super(key: key);

  // Function to build the tab content
  Widget _buildTabContent(String title, String content) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: neutral10,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: mediumTS.copyWith(color: neutral70, fontSize: 14)
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: mediumTS.copyWith(color: neutral100, fontSize: 16)
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          _buildTabContent('Definisi', definisi),
          _buildTabContent('Gejala', gejala),
          _buildTabContent('Solusi', solusi),
        ],
      ),
    );
  }
}
