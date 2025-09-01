import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/cubit/edit_task_state.dart';
import 'package:mvvmproject/features/data/repo/edit_task_repo.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';

enum TaskAction { none, update, delete, markDone }

class EditTaskCubit extends Cubit<EditTaskState> {
  final EditTaskRepo _repo;
  TaskAction lastAction = TaskAction.none;

  EditTaskCubit(this._repo) : super(EditTaskInitial());

  Future<void> markTaskAsDone(String taskId) async {
    try {
      lastAction = TaskAction.markDone;
      emit(EditTaskLoading());
      await _repo.markTaskAsDone(taskId);
      emit(EditTaskSuccess());
    } catch (e) {
      emit(EditTaskFailure('Mark failed: $e'));
    }
  }

  Future<void> updateTask(Map<String, dynamic> taskData) async {
    try {
      lastAction = TaskAction.update;
      emit(EditTaskLoading());

      final updatedTask = TaskModel(
        id: taskData['id'],
        title: taskData['title'],
        description: taskData['description'],
        status: taskData['status'] ?? 'Pending',
        category: taskData['category'] ?? 'Home',
        statusColor: taskData['statusColor'] ?? 0xFF000000,
        iconColor: taskData['iconColor'] ?? 0xFF000000,
        icon: taskData['icon'] ?? 'icon_home',
        statusContainerColor: taskData['statusContainerColor'] ?? 0xFFFFFFFF,
        dateTime: taskData['dateTime'],
      );

      await _repo.updateTask(updatedTask);
      emit(EditTaskSuccess());
    } catch (e) {
      emit(EditTaskFailure('Update failed: $e'));
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      lastAction = TaskAction.delete;
      emit(EditTaskLoading());
      await _repo.deleteTask(taskId);
      emit(EditTaskSuccess());
    } catch (e) {
      emit(EditTaskFailure('Delete failed: $e'));
    }
  }
}