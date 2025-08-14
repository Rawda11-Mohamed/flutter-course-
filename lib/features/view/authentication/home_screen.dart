// lib/features/home/authentication/home_screen.dart
import 'package:flutter/material.dart';
import 'package:mvvmproject/core/widgets/progress_card.dart';
import 'package:mvvmproject/core/widgets/in_progress_tasks.dart';
import 'package:mvvmproject/core/widgets/task_groups.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child:InkWell(onTap: (){Navigator.pushNamed(context, '/profile');},child: Image.asset(
            AppAssets.flag,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              'Ahmed Saber',
              style: TextStyle(
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