import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ✅ Required
import 'package:mvvmproject/core/utils/app_colors.dart';
import 'package:mvvmproject/core/utils/app_paddings.dart';
import 'package:mvvmproject/core/widgets/default_form_field.dart';
import 'package:mvvmproject/core/utils/app_assets.dart';

class TaskFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController groupController;
  final TextEditingController endTimeController;

  const TaskFormFields({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.groupController,
    required this.endTimeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultFormField(
          controller: titleController,
          hintText: 'Title',
          prefixIcon: const Icon(Icons.title, color: AppColors.grey),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.lightGrey),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Description',
              prefixIcon: Icon(Icons.description, color: AppColors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.lightGrey),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: groupController.text.isNotEmpty ? groupController.text : null,
              isExpanded: true,
              hint: Text('Group', style: TextStyle(color: AppColors.grey, fontSize: 14.sp)),
              items: ['Home', 'Personal', 'Work'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: value == 'Home'
                              ? AppColors.taskCardPink
                              : value == 'Personal'
                              ? AppColors.taskCardLightGreen
                              : AppColors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Image.asset(
                            value == 'Home'
                                ? AppAssets.homeTaskIcon
                                : value == 'Personal'
                                ? AppAssets.PersonIcon
                                : AppAssets.workTaskIcon,
                            width: 16,
                            height: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                groupController.text = value!;
              },
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.lightGrey),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: AppColors.green),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: endTimeController,
                  readOnly: true,
                  onTap: () async {
                    // Show date picker
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        endTimeController.text =
                        '${date.day} ${date.month}, ${date.year} ${time.format(context)}';
                      }
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'End Time',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension DateTimeExt on int {
  String get monthName {
    final monthNames = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[this];
  }
}

extension TimeOfDayExt on TimeOfDay {
  String format(BuildContext context) {
    final period = this.period == DayPeriod.pm ? 'pm' : 'am';
    final hour = this.hourOfPeriod == 0 ? 12 : this.hourOfPeriod;
    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }
}