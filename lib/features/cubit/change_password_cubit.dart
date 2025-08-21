import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthRepoImp authRepo;

  ChangePasswordCubit(this.authRepo) : super(ChangePasswordInitial());

  static ChangePasswordCubit get(context) => BlocProvider.of<ChangePasswordCubit>(context);

  Future<void> updatePassword(
      String oldPassword,
      String newPassword,
      String confirmPassword,
      ) async {
    emit(ChangePasswordLoading());

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      emit(ChangePasswordError('All fields are required'));
      return;
    }

    if (newPassword != confirmPassword) {
      emit(ChangePasswordError('New passwords do not match'));
      return;
    }

    if (newPassword.length < 6) {
      emit(ChangePasswordError('Password must be at least 6 characters'));
      return;
    }

    try {
      await authRepo.changePassword(oldPassword, newPassword);
      emit(ChangePasswordSuccess());
    } on Exception catch (e) {
      emit(ChangePasswordError(e.toString()));
    }
  }
}