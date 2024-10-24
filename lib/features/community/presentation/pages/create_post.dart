import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:disoriza/core/common/custom_textfield.dart';
import 'package:disoriza/core/common/fontstyles.dart';
import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/core/common/custom_button.dart';
import '../../../home/presentation/pages/home_onboarding.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _passwordFocus = FocusNode();
  bool areFieldsEmpty = true;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(updateFieldState);
    _descriptionController.addListener(updateFieldState);
    _imageController.addListener(updateFieldState);
  }

  void updateFieldState() {
    setState(() => areFieldsEmpty = _titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _imageController.text.isEmpty);
  }

  @override
  void dispose() {
    _titleController.removeListener(updateFieldState);
    _descriptionController.removeListener(updateFieldState);
    _imageController.removeListener(updateFieldState);
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat postingan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          // Field Judul
          Text('Judul', style: mediumTS.copyWith(color: neutral100)),
          const SizedBox(height: 8),
          CustomFormField(
            controller: _titleController,
            hint: 'Isi Judul',
          ),

          const SizedBox(height: 12),

          // Field Deskripsi
          Text('Deskripsi', style: mediumTS.copyWith(color: neutral100)),
          const SizedBox(height: 8),
          CustomFormField(
            controller: _descriptionController,
            hint: 'Isi Deskripsi',
            maxLines: 5,
            borderradius: 24,
          ),

          const SizedBox(height: 12),

          // Field Upload Image
          Text('Foto (Opsional)', style: mediumTS.copyWith(color: neutral100)),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: neutral10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: neutral10,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: backgroundCanvas),
                  ),
                  child: IconButton(
                    icon: Icon(
                      IconsaxPlusLinear.gallery_add,
                      size: 32,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onPressed: () {
                      // Nothing
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: neutral10,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: backgroundCanvas),
                  ),
                  child: Center(
                    child: Text(
                      'Upload Gambar',
                      style: mediumTS.copyWith(color: neutral100),
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Daftar Button
          CustomButton(
            text: 'Posting',
            disabled: areFieldsEmpty,
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: const HomeOnboarding(),
                  type: PageTransitionType.fade,
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
