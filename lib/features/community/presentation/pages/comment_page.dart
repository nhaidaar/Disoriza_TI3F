import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/delete_alert.dart';
import 'package:disoriza/core/common/fontstyles.dart';
import 'package:disoriza/features/community/presentation/widgets/comment_card.dart';
import 'package:disoriza/features/community/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CommentPage extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool isEnabled;
  final VoidCallback? onTap;

  const CommentPage({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.isEnabled = true,
    this.onTap,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

const List<String> filterMenu = <String>['Terbaru', 'Terpopuler'];

class _CommentPageState extends State<CommentPage> {
  String dropdownValue = filterMenu.first;
  String hint = 'Berikan Komentar';

 void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => const DeleteAlert(
        titleMessage: "Ingin menghapus riwayat ini?",
        detailMessage: "Setelah dihapus, data tidak dapat diurungkan.",
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        // Perform delete action here
        print('Data dihapus'); // Replace with actual delete logic
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral10,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const Text(
              'Detail Diskusi',
              style: TextStyle(fontSize: 16),
            ),
            IconButton(
              icon: const Icon(IconsaxPlusLinear.trash),
              color: dangerMain,
              onPressed: _showDeleteDialog,
            )
          ],
        ),
        backgroundColor: neutral10,
      ),
      body: ListView(
        children: [
          const PostCard(
            isDetailDiscussion: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Komentar',
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton(
                  value: dropdownValue,
                  icon: const Icon(IconsaxPlusLinear.arrow_down),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items:
                      filterMenu.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  underline: const SizedBox.shrink(),
                  dropdownColor: neutral10,
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                CommentCard(),
                CommentCard(),
                CommentCard(),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
      bottomSheet: Container(
        color: neutral10,
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          style: mediumTS.copyWith(
              fontSize: 14, color: widget.isEnabled ? neutral100 : neutral60),
          decoration: InputDecoration(
            enabled: widget.isEnabled,
            filled: true,
            fillColor: backgroundCanvas,
            suffixIcon: const Icon(IconsaxPlusLinear.send_1),
            hintText: hint,
            hintStyle: mediumTS.copyWith(fontSize: 14, color: neutral60),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ),
    );
  }
}
