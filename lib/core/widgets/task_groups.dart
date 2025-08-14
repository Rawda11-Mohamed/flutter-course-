// lib/features/home/authentication/widgets/task_groups.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvvmproject/core/widgets/icons_containers.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_assets.dart';

class TaskGroups extends StatelessWidget {
  const TaskGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Task Groups",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildGroupItem(
            AppAssets.PersonIcon, "Personal Task", AppColors.green, "5"),
        _buildGroupItem(AppAssets.homeTaskIcon, "Home Task", AppColors.pink, "3"),
        _buildGroupItem(AppAssets.workTaskIcon, "Work Task", AppColors.black, ""),
      ],
    );
  }

  Widget _buildGroupItem(
      String iconPath, String title, Color color, String count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                iconPath,
                width: 19,
                height: 20,
              ),
              onPressed: () {

              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          if (count.isNotEmpty)
            CircleAvatar(
              backgroundColor: AppColors.taskCardLightGreen,
              radius: 12,
              child: Text(
                count,
                style: const TextStyle(fontSize: 12, color: AppColors.green),
              ),
            ),
        ],
      ),
    );
  }

}