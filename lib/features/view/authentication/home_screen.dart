import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/core/widgets/progress_card.dart';
import 'package:mvvmproject/core/widgets/in_progress_tasks.dart';
import 'package:mvvmproject/core/widgets/task_groups.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_paddings.dart';
import 'package:mvvmproject/features/cubit/home_cubit.dart';
import 'package:mvvmproject/features/cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeLoaded) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.green,
              onPressed: () {
                Navigator.pushNamed(context, '/addTask');
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: AppPaddings.defaultHomePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, state.username),
                    const SizedBox(height: 25),
                    const ProgressCard(),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "In Progress",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.green,
                          child: Text(
                            "5",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const InProgressTasks(),
                    const SizedBox(height: 25),
                    const TaskGroups(),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(child: Text("Error loading data"));
      },
    );
  }

  Widget _buildHeader(BuildContext context, String username) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: InkWell(
            onTap: () async {
              final updatedName = await Navigator.pushNamed(context, '/profile');
              if (updatedName != null && updatedName is String) {
                context.read<HomeCubit>().updateUsername(updatedName);
              }
            },
            child: Image.asset(
              AppAssets.flag,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}