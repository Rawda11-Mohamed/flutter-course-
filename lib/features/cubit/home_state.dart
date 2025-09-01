import 'package:mvvmproject/features/data/models/task_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String username;
  final List<TaskModel> tasks;
  HomeLoaded({required this.username, required this.tasks});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}