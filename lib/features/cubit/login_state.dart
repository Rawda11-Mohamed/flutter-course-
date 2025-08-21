import 'package:mvvmproject/features/data/models/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginChangePasswordVisibility extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess(this.user);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}