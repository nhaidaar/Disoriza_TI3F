import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_button.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../../core/utils/camera.dart';
import '../../../../core/utils/network_image.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../auth/data/models/user_model.dart';
import '../blocs/setelan_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _namaController = TextEditingController();
  Uint8List? image;

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.user.name ?? '';
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutral10,
        surfaceTintColor: neutral10,
        shape: const Border(
          bottom: BorderSide(color: neutral30),
        ),

        // Back Button
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(IconsaxPlusLinear.arrow_left),
        ),

        title: Text(
          'Edit Profile',
          style: mediumTS.copyWith(fontSize: 16, color: neutral100),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<SetelanBloc, SetelanState>(
        listener: (context, state) {
          if (state is SetelanProfileChanged) showSnackbar(context, message: 'Profil telah diperbarui');
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: neutral10,
                borderRadius: defaultSmoothRadius,
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // Avatar
                        Container(
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(side: BorderSide(color: neutral50)),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: neutral10,
                            backgroundImage: image != null
                                ? MemoryImage(image!)
                                : widget.user.profilePicture != null
                                    ? getImageProvider(widget.user.profilePicture.toString())
                                    : null,
                            child: image != null
                                ? null
                                : widget.user.profilePicture != null
                                    ? null
                                    : const Icon(IconsaxPlusLinear.profile, color: neutral100, size: 32),
                          ),
                        ),

                        // Edit Button
                        GestureDetector(
                          onTap: () async {
                            XFile? pickedImage = await pickImage(context);
                            if (pickedImage != null) {
                              final imageBytes = await pickedImage.readAsBytes();
                              setState(() => image = imageBytes);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: neutral10,
                              boxShadow: const [shadowEffect1],
                            ),
                            child: const Icon(IconsaxPlusLinear.edit, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Field nama
                  Text('Nama', style: mediumTS.copyWith(color: neutral100)),
                  const SizedBox(height: 8),
                  CustomFormField(
                    controller: _namaController,
                    backgroundColor: backgroundCanvas,
                    hint: 'Masukkan nama anda',
                  ),

                  const SizedBox(height: 24),

                  // Save Button
                  state is SetelanLoading
                      ? const CustomLoadingButton()
                      : CustomButton(
                          onTap: () => context.read<SetelanBloc>().add(SetelanChangeProfile(
                                uid: widget.user.id!,
                                name: _namaController.text,
                                image: image,
                              )),
                          text: 'Simpan',
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
