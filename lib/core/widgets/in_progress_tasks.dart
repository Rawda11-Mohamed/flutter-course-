// lib/features/home/authentication/widgets/in_progress_tasks.dart
import 'package:flutter/material.dart';
import 'package:mvvmproject/core/widgets/icons_containers.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';


class InProgressTasks extends StatelessWidget {
  const InProgressTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildTaskCard(
            "Work Task",
            "Add New Features",
            AppAssets.workTaskIcon,
            bgColor: AppColors.black,
            iconBgColor: AppColors.green,
            textColor: AppColors.white,
          ),
          const SizedBox(width: 16),
          _buildTaskCard(
            "Personal Task",
            "Improve my English skills by trying to speak",
            AppAssets.PersonIcon,
            bgColor: AppColors.taskCardLightGreen,
            iconBgColor: AppColors.green,
            textColor: AppColors.blackText,
          ),
          const SizedBox(width: 16),
          _buildTaskCard(
            "Home Task",
            "Add new feature for Do It app and commit it",
            AppAssets.homeTaskIcon,
            bgColor: AppColors.taskCardPink,
            iconBgColor: AppColors.pink,
            textColor: AppColors.blackText,
          ),
        ],
      ),
    );

  }

  Widget _buildTaskCard(
      String title,
      String subtitle,
      String iconPath, {
        required Color bgColor,
        required Color iconBgColor,
        required Color textColor,
      }) {
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
                title,
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
            subtitle,
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