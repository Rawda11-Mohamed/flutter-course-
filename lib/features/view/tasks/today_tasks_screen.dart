import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_paddings.dart';
import 'package:mvvmproject/features/cubit/today_tasks_cubit.dart';
import 'package:mvvmproject/features/cubit/today_tasks_state.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';
import 'package:mvvmproject/core/widgets/task_card.dart';
import 'edit_task_screen.dart';

class TodayTasksScreen extends StatelessWidget {
  const TodayTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = TodayTasksCubit.get(context);

    if (cubit.allTasks.isEmpty) {
      cubit.loadTasks();
    }

    return BlocBuilder<TodayTasksCubit, TodayTasksState>(
      builder: (context, state) {
        if (state is TodayTasksLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is TodayTasksError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: AppPaddings.defaultHomePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 23),
                  _buildSearchBar(context),
                  const SizedBox(height: 30),
                  _buildResultsHeader(cubit.filteredTasks.length),
                  const SizedBox(height: 27),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cubit.filteredTasks.length,
                      itemBuilder: (context, index) {
                        final TaskModel task = cubit.filteredTasks[index];
                        return TaskCard(
                          model: task,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditTaskScreen(model: task),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // filter modal
            },
            backgroundColor: AppColors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.menu),
          ),
        );
      },
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      const Expanded(
        child: Center(
          child: Text(
            'Tasks',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}

Widget _buildSearchBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: TextField(
      onChanged: (value) =>
          context.read<TodayTasksCubit>().updateSearchQuery(value),
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        suffixIcon: Icon(Icons.search, color: Colors.grey),
      ),
    ),
  );
}

Widget _buildResultsHeader(int count) {
  return Row(
    children: [
      const Text(
        'Results',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(width: 8),
      Text(
        '$count',
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    ],
  );
}