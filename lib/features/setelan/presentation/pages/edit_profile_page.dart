import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/common/colors.dart';
import '../../../../core/common/custom_textfield.dart';
import '../../../../core/common/effects.dart';
import '../../../../core/common/fontstyles.dart';
import '../../../auth/data/models/user_model.dart';
import '../cubit/setelan_cubit.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.user.name ?? '';
    _emailController.text = widget.user.email ?? '';
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
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
      body: BlocConsumer<SetelanCubit, SetelanState>(
        listener: (context, state) {
          if (state is SetelanError) {
            // Show error if there's an issue with the request
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is SetelanSuccess) {
            // Show success message when profile is updated successfully
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is SetelanLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: defaultSmoothRadius,
              color: neutral10,
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // Avatar
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/example.jpg'),
                      ),

                      // Edit Button
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: neutral10,
                            boxShadow: const [shadowEffect1],
                          ),
                          child: const Icon(IconsaxPlusLinear.edit, size: 20),
                        ),
                      )
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

                const SizedBox(height: 12),

                // Field email
                Text('Email', style: mediumTS.copyWith(color: neutral100)),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  backgroundColor: backgroundCanvas,
                  hint: 'Masukkan email anda',
                ),

                const SizedBox(height: 24),

                // Save Button
                GestureDetector(
                  onTap: () {
                    context.read<SetelanCubit>().editUser(
                      uid: widget.user.id!,
                      name: _namaController.text,
                      email: _emailController.text,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: accentOrangeMain,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Simpan',
                          style: mediumTS.copyWith(fontSize: 16, color: neutral10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
