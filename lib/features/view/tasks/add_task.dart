import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import '../../../core/widgets/default_btn.dart';
import 'package:mvvmproject/features/cubit/add_task_cubit.dart';
import 'package:mvvmproject/features/cubit/add_task_state.dart';

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
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Task'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/flag.png',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),SizedBox(height: 12),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Group',
                        border: OutlineInputBorder(),
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
                    const SizedBox(height: 12),
                    TextField(
                      readOnly: true,
                      onTap: () => _selectDateAndTime(context),
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        prefixIcon: const Icon(Icons.calendar_month),
                        border: const OutlineInputBorder(),
                        suffixIcon: endTime != null
                            ? Text("${endTime!.day}/${endTime!.month}/${endTime!.year}")
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
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
