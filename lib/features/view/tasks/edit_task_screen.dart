import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvmproject/features/cubit/edit_task_cubit.dart';
import 'package:mvvmproject/features/cubit/edit_task_state.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';

class DefaultBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const DefaultBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.w,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: -0.41,
          ),
        ),
      ),
    );
  }
}

class EditTaskScreen extends StatefulWidget {
  final Map<String, dynamic>? taskData;
  final VoidCallback? onDelete;

  const EditTaskScreen({super.key, this.taskData, this.onDelete});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String selectedDate;
  String? selectedCategory;

  final Set<String> uniqueCategories = {'Work', 'Home', 'Personal'};

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.taskData?['title'] ?? 'Unnamed Task');
    descriptionController = TextEditingController(text: widget.taskData?['description'] ?? '');
    selectedDate = widget.taskData?['dateTime'] ?? '30 June, 2022   10:00 pm';
    selectedCategory = widget.taskData?['category'];

    if (!uniqueCategories.contains(selectedCategory)) {
      selectedCategory = 'Home';
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final dateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        final months = [
          'January', 'February', 'March', 'April', 'May', 'June',
          'July', 'August', 'September', 'October', 'November', 'December'
        ];
        final hour = pickedTime.hour;
        final minute = pickedTime.minute.toString().padLeft(2, '0');
        final period = hour >= 12 ? 'pm' : 'am';
        final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
        final formattedTime = '$displayHour:$minute $period';
        final formattedDate = '${dateTime.day} ${months[dateTime.month - 1]}, ${dateTime.year}   $formattedTime';

        setState(() {
          selectedDate = formattedDate;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: BlocListener<EditTaskCubit, EditTaskState>(
            listener: (context, state) {
              if (state is EditTaskSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text('Action completed successfully!'),
                    backgroundColor: AppColors.primary,
                  ));
                Future.delayed(const Duration(milliseconds: 600), () {
                  Navigator.maybePop(context);
                });
              } else if (state is EditTaskFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: AppColors.statusMissed,
                  ));
              }
            },
            child: Stack(
              children: [
                _buildBody(context),
                BlocBuilder<EditTaskCubit, EditTaskState>(
                  builder: (context, state) {
                    if (state is EditTaskLoading) {
                      return Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Edit Task',
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
          letterSpacing: -0.41,
        ),
      ),
      actions: [
        Container(
          width: 80.w,
          height: 28.h,
          margin: EdgeInsets.only(right: 16.w),
          child: ElevatedButton(
            onPressed: () {
              final taskId = widget.taskData?['id'];
              if (taskId == null || taskId.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task ID is missing')),
                );
                return;
              }
              context.read<EditTaskCubit>().deleteTask(taskId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE4312B), // red from CSS
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              elevation: 0,
              padding: EdgeInsets.zero,
            ),
            child: Text(
              'Delete',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 24.h),
          _buildDropdownCard(),
          SizedBox(height: 16.h),
          _buildInfoCard(controller: titleController, isTitle: true),
          SizedBox(height: 16.h),
          _buildInfoCard(controller: descriptionController, isTitle: false),
          SizedBox(height: 16.h),
          _buildDateCard(context),
          SizedBox(height: 40.h),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(AppAssets.flag),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.taskData?['status'] ?? 'In Progress',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightGrey,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.taskData?['description'] ?? 'Believe you can, and you\'re halfway there.',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedCategory,
        items: uniqueCategories.map((cat) {
          return DropdownMenuItem(
            value: cat,
            child: Text(cat),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCategory = value;
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Select Category',
          hintStyle: TextStyle(color: AppColors.lightGrey),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required TextEditingController controller, bool isTitle = true}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: isTitle ? 17.sp : 15.sp,
          fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400,
          color: AppColors.black,
          letterSpacing: isTitle ? -0.41 : 0,
          height: 1.4,
        ),
        maxLines: isTitle ? 1 : 5,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: isTitle ? 'Enter title' : 'Enter description',
          hintStyle: TextStyle(
            color: AppColors.lightGrey,
            fontSize: isTitle ? 17.sp : 15.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildDateCard(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined, color: AppColors.primary, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                selectedDate,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(Icons.edit, color: AppColors.lightGrey, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        DefaultBtn(
          text: 'Mark as Done',
          onPressed: () {
            final taskId = widget.taskData?['id'];
            if (taskId == null || taskId.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task ID is missing')),
              );
              return;
            }
            context.read<EditTaskCubit>().markTaskAsDone(taskId);
          },
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 327.w,
          height: 56.h,
          child: OutlinedButton(
            onPressed: () {
              final taskId = widget.taskData?['id'];
              if (taskId == null || taskId.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task ID is missing')),
                );
                return;
              }

              final taskData = {
                'id': taskId,
                'title': titleController.text.trim(),
                'description': descriptionController.text.trim(),
                'dateTime': selectedDate,
                'category': selectedCategory,
                'status': widget.taskData?['status'] ?? 'Pending',
                'statusColor': widget.taskData?['statusColor'] ?? 0xFF000000,
                'iconColor': widget.taskData?['iconColor'] ?? 0xFF000000,
                'icon': 'icon_${selectedCategory?.toLowerCase()}' ?? 'icon_home',
                'statusContainerColor': widget.taskData?['statusContainerColor'] ?? 0xFFFFFFFF,
              };

              final title = taskData['title'];
              if (title == null || title.toString().trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Title is required')),
                );
                return;
              }

              context.read<EditTaskCubit>().updateTask(taskData);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              'Update',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                letterSpacing: -0.41,
              ),
            ),
          ),
        ),
      ],
    );
  }
}