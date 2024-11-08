import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import 'package:disoriza/core/common/custom_textfield.dart';
import 'package:disoriza/core/common/fontstyles.dart';
import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../core/common/custom_popup.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../user/data/models/user_model.dart';
import '../../data/models/post_model.dart';
import '../cubit/komunitas/komunitas_cubit.dart';

class CreatePostPage extends StatefulWidget {
  final User user;
  const CreatePostPage({super.key, required this.user});

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
    return BlocConsumer<KomunitasCubit, KomunitasState>(
      listener: (context, state) {
        if (state is CreatePostSuccess) {
          Navigator.of(context).pop();
          showSnackbar(context, message: 'Postingan berhasil terunggah');
        }
      },
      builder: (context, state) {
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
                            GestureDetector(
                              onTap: () {},
                              child: Container(
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
                  child: state is KomunitasLoading
                      ? const CustomLoadingButton()
                      : CustomButton(
                          text: 'Posting',
                          disabled: areFieldsEmpty,
                          onTap: () {
                            context.read<KomunitasCubit>().createPost(
                                  post: PostModel(
                                    title: _titleController.text,
                                    content: _descriptionController.text,
                                    creator: UserModel(id: widget.user.$id),
                                    date: DateTime.now().millisecondsSinceEpoch,
                                  ),
                                );
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
