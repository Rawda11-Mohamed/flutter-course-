import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';
import 'package:mvvmproject/core/widgets/option_item.dart';
import 'package:mvvmproject/core/utils/app_paddings.dart';
import 'package:mvvmproject/features/cubit/home_cubit.dart';
import 'package:mvvmproject/features/cubit/home_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.defaultHomePadding,
          child: Column(
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(AppAssets.flag),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello!',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Text(
                              state.username,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return const Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(AppAssets.flag),
                      ),
                      SizedBox(width: 15),
                      Text("Loading..."),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              OptionItem(
                icon: Icons.person_outline,
                text: 'Profile',
                onTap: () async {
                  final updatedName = await Navigator.pushNamed(context, '/updateName');
                  if (updatedName != null && updatedName is String) {
                    context.read<HomeCubit>().updateUsername(updatedName);
                  }
                },
              ),
              OptionItem(
                icon: Icons.lock_outline,
                text: 'Change Password',
                onTap: () => Navigator.pushNamed(context, '/changePassword'),
              ),
              OptionItem(
                icon: Icons.language,
                text: 'Language',
                onTap: () async {
                  final newLang = await Navigator.pushNamed(context, '/language');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}