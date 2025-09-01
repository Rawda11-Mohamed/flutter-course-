import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import '../../../core/widgets/default_btn.dart';
import 'package:mvvmproject/features/cubit/add_task_cubit.dart';
import 'package:mvvmproject/features/cubit/add_task_state.dart';
import 'package:mvvmproject/features/cubit/home_cubit.dart';
import '../../../core/utils/app_paddings.dart';
import '../../../core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String? selectedGroup;
  DateTime? endTime;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        endTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTaskCubit(AuthRepoImp()),
      child: BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (context, state) {
          if (state is AddTaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AddTaskSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Task added successfully")),
            );
            // Refresh home screen tasks
            try {
              context.read<HomeCubit>().refreshTasks();
            } catch (e) {
              // HomeCubit might not be available in this context
            }
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF3F5F4), // grey background
            appBar: AppBar(
              backgroundColor: const Color(0xFFF3F5F4),
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Add Task',
                style: TextStyle(
                  fontFamily: 'Lexend Deca',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 19,
                  color: Color(0xFF24252C), // Color/Black
                ),
              ),
              leading: IconButton(
                icon: Transform.rotate(
                  angle: -90 * 3.14159 / 180, // -90 degrees in radians
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              padding: AppPaddings.defaultHomePadding,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Image - keeping unchanged as requested
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/flag.png',
                        height: 207.h,
                        width: 261.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 29),
                    
                    // Title Field
                    Container(
                      width: double.infinity,
                      height: 63,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:AppColors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 32,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: titleController,
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          fontSize: 16,
                          color: Color(0xFF24252C),
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 16, top: 20),
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            color: AppColors.grey, // grey grey
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Description Field
                    Container(
                      width: double.infinity,
                      height: 63,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 32,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: descriptionController,
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          fontSize: 16,
                          color: Color(0xFF24252C),
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 16, top: 20),
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            color: Color(0xFF6E6A7C), // grey grey
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Group Dropdown
                    Container(
                      width: double.infinity,
                      height: 63,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFCDCDCD)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 32,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedGroup,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 16, top: 20),
                          labelText: 'Group',
                          labelStyle: const TextStyle(
                            fontFamily: 'Lexend Deca',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            color: AppColors.grey, // grey grey
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Transform.rotate(
                              angle: 180 * 3.14159 / 180, // 180 degrees in radians
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 21,
                              ),
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          fontSize: 16,
                          color: Color(0xFF24252C),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'home', child: Text('Home')),
                          DropdownMenuItem(value: 'personal', child: Text('Personal')),
                          DropdownMenuItem(value: 'work', child: Text('Work')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedGroup = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a group';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // End Time Field
                    Container(
                      width: double.infinity,
                      height: 63,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFCDCDCD)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 32,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        onTap: () => _selectDateAndTime(context),
                        child: Row(
                          children: [
                            const SizedBox(width: 19),
                            const Icon(
                              Icons.calendar_today,
                              color: AppColors.primary, // green
                              size: 24,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'End Time',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  if (endTime != null)
                                    Text(
                                      "${endTime!.day}/${endTime!.month}/${endTime!.year}",
                                      style: const TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        fontSize: 16,
                                        color: Color(0xFF24252C),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Add Task Button - keeping unchanged as requested
                    state is AddTaskLoading
                        ? const CircularProgressIndicator()
                        : DefaultBtn(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AddTaskCubit>().addTask(
                            title: titleController.text,
                            description: descriptionController.text,
                            group: selectedGroup!,
                            endTime: endTime,
                          );
                        }
                      },
                      text: 'Add Task',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
