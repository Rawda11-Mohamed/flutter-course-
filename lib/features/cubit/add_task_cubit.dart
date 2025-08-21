import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';
import 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final AuthRepoImp authRepo;

  AddTaskCubit(this.authRepo) : super(AddTaskInitial());

  static AddTaskCubit get(context) => BlocProvider.of<AddTaskCubit>(context);

  Future<void> addTask({
    required String title,
    required String description,
    required String group,
    DateTime? endTime,
  }) async {
    emit(AddTaskLoading());

    if (title.trim().isEmpty || description.trim().isEmpty || group.isEmpty) {
      emit(AddTaskError('Please fill all fields'));
      return;
    }

    try {
      final user = authRepo.auth.currentUser;
      if (user == null) throw Exception("No user is signed in.");

      final task = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        status: 'pending',
        category: group,
        statusColor: 0xFF2196F3,
        iconColor: 0xFFFFFFFF,
        icon: 'task',
        statusContainerColor: 0x402196F3,
        dateTime: endTime?.toIso8601String(),
      );

      await authRepo.firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc(task.id)
          .set(task.toJson());

      emit(AddTaskSuccess());
    } on Exception catch (e) {
      emit(AddTaskError(e.toString()));
    }
  }
}