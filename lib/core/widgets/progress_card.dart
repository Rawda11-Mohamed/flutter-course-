// lib/features/home/authentication/widgets/progress_card.dart
import 'package:flutter/material.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';
import '../../../../core/utils/app_colors.dart';

class ProgressCard extends StatelessWidget {
  final List<TaskModel> tasks;
  
  const ProgressCard({super.key, required this.tasks});

  double get progressPercentage {
    if (tasks.isEmpty) return 0.0;
    
    final completedTasks = tasks.where((task) => task.status == 'Done').length;
    final totalTasks = tasks.length;
    
    return totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tasks.isEmpty 
                    ? "No tasks yet!" 
                    : "Your today's tasks almost done!",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  "${progressPercentage.toInt()}%",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/todayTasks');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "View Tasks",
              style: TextStyle(color: AppColors.green),
            ),
          )
        ],
      ),
    );
  }
}