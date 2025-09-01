import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import 'package:mvvmproject/features/data/models/task_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AuthRepoImp authRepo;
  
  HomeCubit(this.authRepo) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  List<TaskModel> _allTasks = [];
  String _username = 'User';

  List<TaskModel> get allTasks => _allTasks;
  String get username => _username;

  // Get tasks by status
  List<TaskModel> get inProgressTasks => _allTasks.where((task) => 
    task.status == 'Pending' || task.status == 'In Progress'
  ).toList();

  // Get tasks by category
  List<TaskModel> get personalTasks => _allTasks.where((task) => 
    task.category.toLowerCase() == 'personal'
  ).toList();

  List<TaskModel> get homeTasks => _allTasks.where((task) => 
    task.category.toLowerCase() == 'home'
  ).toList();

  List<TaskModel> get workTasks => _allTasks.where((task) => 
    task.category.toLowerCase() == 'work'
  ).toList();

  void updateUsername(String newUsername) {
    _username = newUsername;
    emit(HomeLoaded(username: _username, tasks: _allTasks));
  }

  void loadUserData(String username) {
    _username = username;
    loadTasks();
  }

  Future<void> loadTasks() async {
    emit(HomeLoading());
    try {
      final user = authRepo.auth.currentUser;
      if (user == null) {
        emit(HomeError("No user is signed in."));
        return;
      }

      final snapshot = await authRepo.firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .get();

      _allTasks = snapshot.docs.map((doc) {
        try {
          return TaskModel.fromJson({...doc.data(), 'id': doc.id});
        } catch (e) {
          return null;
        }
      }).where((task) => task != null).cast<TaskModel>().toList();

      emit(HomeLoaded(username: _username, tasks: _allTasks));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void refreshTasks() {
    loadTasks();
  }
}