import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';
import 'package:mvvmproject/features/cubit/edit_task_cubit.dart';
import 'package:mvvmproject/features/cubit/edit_task_state.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_paddings.dart';
import '../../../core/widgets/default_btn.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel model;

  const EditTaskScreen({super.key, required this.model});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditTaskCubit(
        context.read<AuthRepoImp>(),
        task: widget.model,
      ),
      child: BlocConsumer<EditTaskCubit, EditTaskState>(
        listener: (context, state) {
          if (state is EditTaskSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Task updated')));
          }
          if (state is EditTaskDeleted) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = EditTaskCubit.get(context);

          titleController.text = cubit.task.title;
          descController.text = cubit.task.description;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Task'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    cubit.deleteTask();
                  },
                ),
              ],
            ),
            body: Padding(
              padding: AppPaddings.defaultHomePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    onChanged: (value) => cubit.updateTitle(value),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descController,
                    onChanged: (value) => cubit.updateDescription(value),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  DefaultBtn(
                    text: 'Mark as Done',
                    onPressed: () {
                      cubit.markAsDone();
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.updateTask();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}