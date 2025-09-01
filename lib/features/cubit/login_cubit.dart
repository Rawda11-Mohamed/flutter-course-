import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepoImp authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool passwordSecure = true;

  void changePasswordVisibility() {
    passwordSecure = !passwordSecure;
    emit(LoginChangePasswordVisibility());
  }

  Future<void> login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      emit(LoginError('Please enter email and password'));
      return;
    }

    if (!email.contains('@')) {
      emit(LoginError('Please enter a valid email'));
      return;
    }

    emit(LoginLoading());

    final result = await authRepo.login(email: email, password: password);

    result.fold(
          (failure) => emit(LoginError(failure.message)), // Left => error
          (user) => emit(LoginSuccess(user)),             // Right => success
    );
  }
}
