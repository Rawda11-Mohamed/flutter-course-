import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import'today_tasks_state.dart';

class TodayTasksCubit extends Cubit<TodayTasksState> {
  TodayTasksCubit() : super(const TodayTasksState());

  void setTasks(List<TaskModel> tasks) {
    emit(state.copyWith(tasks: tasks));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  List<TaskModel> get filteredTasks {
    if (state.searchQuery.isEmpty) return state.tasks;
    return state.tasks.where((t) => t.task.toLowerCase().contains(state.searchQuery.toLowerCase())).toList();
  }
}
