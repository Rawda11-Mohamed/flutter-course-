// lib/core/widgets/task_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  final TaskModel model;
  final VoidCallback? onTap;
  final VoidCallback? onIconTap;

  const TaskCard({
    super.key,
    required this.model,
    this.onTap,
    this.onIconTap,
  });

  String get displayStatus {
    if (model.status == 'Done') {
      return 'Done';
    }

    if (model.dateTime != null) {
      final taskDate = DateTime.parse(model.dateTime!);
      final now = DateTime.now();
      if (taskDate.isBefore(now) && model.status != 'Done') {
        return 'Missed';
      }
    }

    return 'In Progress';
  }


  Color get statusColor {
    switch (model.status) {
      case 'Pending':
        return AppColors.black;
      case 'Done':
        return AppColors.white;
      case 'Missed':
        return AppColors.white;
      default:
        return AppColors.black;
    }
  }

  Color get statusBgColor {
    switch (model.status) {
      case 'Pending':
        return AppColors.taskCardLightGreen;
      case 'Done':
        return AppColors.primary;
      case 'Missed':
        return AppColors.statusMissed;
      default:
        return AppColors.primary;
    }
  }

  String get iconAsset {
    switch (model.category.toLowerCase()) {
      case 'work':
        return AppAssets.workTaskIcon;
      case 'personal':
        return AppAssets.PersonIcon;
      case 'home':
        return AppAssets.homeTaskIcon;
      default:
        return AppAssets.workTaskIcon;
    }
  }

  Color get bgColor {
    switch (model.category.toLowerCase()) {
      case 'work':
        return AppColors.black;
      case 'personal':
        return AppColors.taskCardLightGreen;
      case 'home':
        return AppColors.taskCardPink;
      default:
        return AppColors.black;
    }
  }

  Color get iconBgColor {
    switch (model.category.toLowerCase()) {
      case 'work':
        return AppColors.black;
      case 'personal':
        return AppColors.primary;
      case 'home':
        return AppColors.pink;
      default:
        return AppColors.green;
    }
  }

  Color get textColor {
    return AppColors.blackText; // Default text color
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/GettyImages-1315607788 2 (1).png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      model.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: textColor.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusBgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            displayStatus,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 11.0),
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: iconBgColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: SvgPicture.asset(
                              iconAsset,
                              width: 12,
                              height: 12,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                            onPressed: onIconTap ?? () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}