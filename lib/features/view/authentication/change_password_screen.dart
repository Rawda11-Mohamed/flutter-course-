import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/default_form_field.dart';
import '../../../core/widgets/default_btn.dart';
import '../../../core/utils/app_paddings.dart';
import 'package:mvvmproject/features/cubit/change_password_cubit.dart';
import 'package:mvvmproject/features/cubit/change_password_state.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthRepoImp(); // Provide the required dependency

    return BlocProvider(
      create: (_) => ChangePasswordCubit(authRepo),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password updated successfully")),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.greyBackground,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      AppAssets.flag,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: AppPaddings.defaultHomePadding,
                    child: Column(
                      children: [
                        DefaultFormField(
                          controller: _oldPassController,
                          hintText: 'Old Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        DefaultFormField(
                          controller: _newPassController,
                          hintText: 'New Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        DefaultFormField(
                          controller: _confirmPassController,
                          hintText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          obscureText: true,
                        ),
                        const SizedBox(height: 40),
                        state is ChangePasswordLoading
                            ? const CircularProgressIndicator()
                            : DefaultBtn(
                          text: "Save",
                          onPressed: () {
                            context.read<ChangePasswordCubit>().updatePassword(
                              _oldPassController.text,
                              _newPassController.text,
                              _confirmPassController.text,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}