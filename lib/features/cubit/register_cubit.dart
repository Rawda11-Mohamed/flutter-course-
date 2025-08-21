import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mvvmproject/features/data/models/user_model.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepoImp authRepo;

  RegisterCubit(this.authRepo) : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool passwordSecure = true;
  bool confirmPasswordSecure = true;

  void changePasswordVisibility() {
    passwordSecure = !passwordSecure;
    emit(RegisterChangePasswordVisibility());
  }

  void changeConfirmPasswordVisibility() {
    confirmPasswordSecure = !confirmPasswordSecure;
    emit(RegisterChangeConfirmPasswordVisibility());
  }

  Future<void> register() async {
    final String name = usernameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      emit(RegisterError('Please fill all fields'));
      return;
    }

    if (!email.contains('@')) {
      emit(RegisterError('Please enter a valid email'));
      return;
    }

    if (password != confirmPassword) {
      emit(RegisterError('Passwords do not match'));
      return;
    }

    emit(RegisterLoading());
    try {
      final user = await authRepo.register(name: name, email: email, password: password);
      emit(RegisterSuccess(user));
    } on Exception catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}