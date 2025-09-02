import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/default_form_field.dart';
import '../../../../core/utils/app_paddings.dart';
import 'package:mvvmproject/features/cubit/update_name_cubit.dart';
import 'package:mvvmproject/features/cubit/update_name_state.dart';
import '../../../../features/data/repo/auth_repo_imp.dart';
import 'package:mvvmproject/core/widgets/default_btn.dart';

class UpdateNameScreen extends StatefulWidget {
  const UpdateNameScreen({super.key});

  @override
  State<UpdateNameScreen> createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateNameCubit(AuthRepoImp()),
      child: BlocConsumer<UpdateNameCubit, UpdateNameState>(
        listener: (context, state) {
          if (state is UpdateNameError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is UpdateNameSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Name updated successfully')),
            );
            Navigator.pop(context, state.updatedName);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Update Name')),
            body: Padding(
              padding: AppPaddings.defaultHomePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.flag),
                  const SizedBox(height: 20),
                  DefaultFormField(
                    controller: _nameController,
                    hintText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 30),
                  state is UpdateNameLoading
                      ? const CircularProgressIndicator()
                      : DefaultBtn(
                        text: "Save",
                        onPressed: () {
                          context.read<UpdateNameCubit>().updateName(
                            _nameController.text,
                          );
                        },
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
