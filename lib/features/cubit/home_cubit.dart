import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  void updateUsername(String newUsername) {
    emit(HomeLoaded(username: newUsername));
  }

  void loadUserData(String username) {
    emit(HomeLoaded(username: username));
  }
}