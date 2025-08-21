import 'package:mvvmproject/features/data/models/task_model.dart';

abstract class TodayTasksState {}

class TodayTasksInitial extends TodayTasksState {}

class TodayTasksLoading extends TodayTasksState {}

class TodayTasksLoaded extends TodayTasksState {
  final List<TaskModel> tasks;
  TodayTasksLoaded(this.tasks);
}

class TodayTasksError extends TodayTasksState {
  final String message;
  TodayTasksError(this.message);
}