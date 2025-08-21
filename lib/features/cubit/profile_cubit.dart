import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial("Ahmed Saber"));

  void updateName(String newName) {
    emit(ProfileInitial(newName));
  }
}
