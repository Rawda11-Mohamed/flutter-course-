// lib/features/cubit/edit_task_state.dart

import 'package:mvvmproject/features/data/models/task_model.dart';

abstract class EditTaskState {}

class EditTaskInitial extends EditTaskState {}

class EditTaskLoading extends EditTaskState {}

class EditTaskSuccess extends EditTaskState {}

class EditTaskDeleted extends EditTaskState {}

class EditTaskError extends EditTaskState {
  final String message;
  EditTaskError(this.message);
}