import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';
import 'today_tasks_state.dart';

class TodayTasksCubit extends Cubit<TodayTasksState> {
  final AuthRepoImp authRepo;

  TodayTasksCubit(this.authRepo) : super(TodayTasksInitial());

  static TodayTasksCubit get(context) => BlocProvider.of<TodayTasksCubit>(context);

  List<TaskModel> _allTasks = [];
  List<TaskModel> _filteredTasks = [];
  String _searchQuery = '';
  List<TaskModel> get allTasks => _allTasks;

  List<TaskModel> get filteredTasks => _filteredTasks;

  Future<void> loadTasks() async {
    emit(TodayTasksLoading());
    try {
      final user = authRepo.auth.currentUser;
      if (user == null) throw Exception("No user is signed in.");

      final snapshot = await authRepo.firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .get();

      _allTasks = snapshot.docs.map((doc) {
        return TaskModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();

      _filteredTasks = List.from(_allTasks);
      emit(TodayTasksLoaded(_allTasks));
    } on Exception catch (e) {
      emit(TodayTasksError(e.toString()));
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilter();
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredTasks = List.from(_allTasks);
    } else {
      _filteredTasks = _allTasks.where((task) {
        return task.title.toLowerCase().contains(_searchQuery) ||
            task.description.toLowerCase().contains(_searchQuery) ||
            task.category.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    emit(TodayTasksLoaded(_filteredTasks));
  }
}