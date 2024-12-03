import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_popup.dart';
import '../../../../core/utils/camera.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../auth/data/models/user_model.dart';
import '../blocs/komunitas_post/komunitas_post_bloc.dart';

class CreatePostPage extends StatefulWidget {
  final UserModel user;
  const CreatePostPage({super.key, required this.user});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Uint8List? image;

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
                    backgroundColor: neutral10,
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
    return BlocConsumer<KomunitasPostBloc, KomunitasPostState>(
      listener: (context, state) {
        if (state is KomunitasPostCreated) {
          Navigator.of(context).pop();
          showSnackbar(context, message: 'Postingan berhasil terunggah');
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: areFieldsEmpty,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            final shouldPop = await _onPopInvoked();
            if (shouldPop && context.mounted) Navigator.of(context).pop();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: neutral10,
              surfaceTintColor: neutral10,
              shape: const Border(
                bottom: BorderSide(color: neutral30),
              ),

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
                              height: image != null ? 212 : 141,
                              decoration: BoxDecoration(
                                border: Border.all(color: neutral30),
                                borderRadius: BorderRadius.circular(24),
                                image: image != null
                                    ? DecorationImage(image: MemoryImage(image!), fit: BoxFit.cover)
                                    : null,
                              ),
                              child: image != null
                                  ? null
                                  : Center(
                                      child: Text(
                                        'Silahkan upload gambar\nterlebih dahulu',
                                        style: mediumTS.copyWith(fontSize: 12, color: neutral70),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                            ),

                            const SizedBox(height: 8),

                            // Upload Gambar button
                            GestureDetector(
                              onTap: () async {
                                XFile? pickedImage = await pickImage(context);
                                if (pickedImage != null) {
                                  final imageBytes = await pickedImage.readAsBytes();
                                  setState(() => image = imageBytes);
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: neutral30),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  image != null ? 'Ubah Gambar' : 'Upload Gambar',
                                  style: mediumTS.copyWith(fontSize: 12, color: neutral100),
                                  textAlign: TextAlign.center,
                                ),
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
                  child: state is KomunitasPostLoading
                      ? const CustomLoadingButton()
                      : CustomButton(
                          text: 'Posting',
                          disabled: areFieldsEmpty,
                          onTap: () {
                            context.read<KomunitasPostBloc>().add(KomunitasCreatePost(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  uid: widget.user.id.toString(),
                                  image: image,
                                ));
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
