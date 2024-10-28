import 'package:flutter/material.dart';

import 'package:disoriza/core/common/custom_textfield.dart';
import 'package:disoriza/core/common/fontstyles.dart';
import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/custom_button.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/custom_popup.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool areFieldsEmpty = true;

  void updateFieldState() {
    setState(() {
      areFieldsEmpty = _titleController.text.isEmpty || _descriptionController.text.isEmpty;
    });
  }

  Future<bool> _onPopInvoked() async {
    if (areFieldsEmpty) {
      return true;
    }

    // Show confirmation dialog
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) {
        return CustomPopup(
          icon: IconsaxPlusLinear.trash,
          iconColor: dangerMain,
          title: 'Ingin batalkan postingan?',
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.of(context).pop(true),
                    text: 'Ya, Batalkan',
                    backgroundColor: dangerMain,
                    pressedColor: dangerPressed,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: CustomButton(
                    onTap: () => Navigator.of(context).pop(false),
                    text: 'Tidak, lanjut',
                    backgroundColor: Colors.transparent,
                    pressedColor: neutral50,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    return shouldPop ?? false;
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(updateFieldState);
    _descriptionController.addListener(updateFieldState);
  }

  @override
  void dispose() {
    _titleController.removeListener(updateFieldState);
    _descriptionController.removeListener(updateFieldState);
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: areFieldsEmpty,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _onPopInvoked();
        if (shouldPop && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: neutral10,
          surfaceTintColor: neutral10,

          // Back Button
          leading: IconButton(
            onPressed: () async {
              if (await _onPopInvoked()) {
                if (context.mounted) Navigator.of(context).pop();
              }
            },
            icon: const Icon(IconsaxPlusLinear.arrow_left),
          ),

          title: Text(
            'Buat postingan',
            style: mediumTS.copyWith(fontSize: 16, color: neutral100),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // Field Judul
                  Text(
                    'Judul',
                    style: mediumTS.copyWith(color: neutral100),
                  ),
                  const SizedBox(height: 8),
                  CustomFormField(
                    controller: _titleController,
                    hint: 'Isi Judul',
                  ),

                  const SizedBox(height: 12),

                  // Field Deskripsi
                  Text(
                    'Deskripsi',
                    style: mediumTS.copyWith(color: neutral100),
                  ),
                  const SizedBox(height: 8),
                  CustomFormField(
                    controller: _descriptionController,
                    hint: 'Isi Deskripsi',
                    maxLines: 8,
                    borderradius: 16,
                  ),

                  const SizedBox(height: 12),

                  // Field Upload Image
                  Text(
                    'Foto (Opsional)',
                    style: mediumTS.copyWith(color: neutral100),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: neutral10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image preview
                        Container(
                          padding: const EdgeInsets.all(58),
                          decoration: BoxDecoration(
                            border: Border.all(color: neutral30),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Center(
                            child: Icon(IconsaxPlusLinear.gallery_add),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Upload Gambar button
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: neutral30),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            'Upload Gambar',
                            style: mediumTS.copyWith(fontSize: 12, color: neutral100),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Daftar Button
            Container(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                text: 'Posting',
                disabled: areFieldsEmpty,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
