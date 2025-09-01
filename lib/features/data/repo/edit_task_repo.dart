import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';

class EditTaskRepo {
  final AuthRepoImp authRepo;

  EditTaskRepo(this.authRepo);

  Future<void> updateTask(TaskModel task) async {
    final result = await authRepo.updateTask(task);
    if (result.isLeft()) {
      throw Exception(result.fold((l) => l.message, (r) => ''));
    }
  }

  Future<void> deleteTask(String taskId) async {
    final result = await authRepo.deleteTask(taskId);
    if (result.isLeft()) {
      throw Exception(result.fold((l) => l.message, (r) => ''));
    }
  }

  Future<void> markTaskAsDone(String taskId) async {
    final result = await authRepo.updateTaskStatus(taskId, 'Done');
    if (result.isLeft()) {
      throw Exception(result.fold((l) => l.message, (r) => ''));
    }
  }
}