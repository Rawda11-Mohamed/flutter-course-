// lib/features/home/authentication/widgets/in_progress_tasks.dart
import 'package:flutter/material.dart';
import 'package:mvvmproject/core/widgets/icons_containers.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InProgressTasks extends StatelessWidget {
  final List<TaskModel> tasks;
  
  const InProgressTasks({super.key, required this.tasks});

  List<TaskModel> get inProgressTasks => tasks.where((task) => 
    task.status == 'Pending' || task.status == 'In Progress'
  ).take(3).toList();

  @override
  Widget build(BuildContext context) {
    if (inProgressTasks.isEmpty) {
      return const SizedBox(
        height: 90,
        child: Center(
          child: Text(
            'No tasks in progress',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: inProgressTasks.length,
        itemBuilder: (context, index) {
          final task = inProgressTasks[index];
          return Padding(
            padding: EdgeInsets.only(right: index < inProgressTasks.length - 1 ? 16 : 0),
            child: _buildTaskCard(task),
          );
        },
      ),
    );
  }

  Widget _buildTaskCard(TaskModel task) {
    Color bgColor;
    Color iconBgColor;
    Color textColor;
    String iconPath;

    switch (task.category.toLowerCase()) {
      case 'work':
        bgColor = AppColors.black;
        iconBgColor = AppColors.green;
        textColor = AppColors.white;
        iconPath = AppAssets.workTaskIcon;
        break;
      case 'personal':
        bgColor = AppColors.taskCardLightGreen;
        iconBgColor = AppColors.green;
        textColor = AppColors.blackText;
        iconPath = AppAssets.PersonIcon;
        break;
      case 'home':
        bgColor = AppColors.taskCardPink;
        iconBgColor = AppColors.pink;
        textColor = AppColors.blackText;
        iconPath = AppAssets.homeTaskIcon;
        break;
      default:
        bgColor = AppColors.black;
        iconBgColor = AppColors.green;
        textColor = AppColors.white;
        iconPath = AppAssets.workTaskIcon;
    }

    return Container(
      width: 234,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task.category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    iconPath,
                    width: 12,
                    height: 12,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Text(
            task.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}