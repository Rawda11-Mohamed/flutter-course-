import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';
import 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  final AuthRepoImp authRepo;

  TaskModel task;

  EditTaskCubit(this.authRepo, {required this.task}) : super(EditTaskInitial());

  static EditTaskCubit get(context) => BlocProvider.of<EditTaskCubit>(context);

  void loadTask(TaskModel model) {
    task = model;
    emit(EditTaskInitial());
  }

  void updateTitle(String title) {
    task = task.copyWith(title: title);
  }

  void updateDescription(String description) {
    task = task.copyWith(description: description);
  }

  Future<void> markAsDone() async {
    emit(EditTaskLoading());
    try {
      await authRepo.updateTaskStatus(task.id, 'completed');
      task = task.copyWith(status: 'completed');
      emit(EditTaskSuccess());
    } on Exception catch (e) {
      emit(EditTaskError(e.toString()));
    }
  }

  Future<void> updateTask() async {
    emit(EditTaskLoading());
    try {
      await authRepo.updateTask(task);
      emit(EditTaskSuccess());
    } on Exception catch (e) {
      emit(EditTaskError(e.toString()));
    }
  }

  Future<void> deleteTask() async {
    emit(EditTaskLoading());
    try {
      await authRepo.deleteTask(task.id);
      emit(EditTaskDeleted());
    } on Exception catch (e) {
      emit(EditTaskError(e.toString()));
    }
  }
}