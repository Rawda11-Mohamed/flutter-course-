abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final String username;
  HomeLoaded({required this.username});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}