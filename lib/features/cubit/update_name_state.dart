abstract class UpdateNameState {}

class UpdateNameInitial extends UpdateNameState {}

class UpdateNameLoading extends UpdateNameState {}

class UpdateNameSuccess extends UpdateNameState {
  final String updatedName;
  UpdateNameSuccess(this.updatedName);
}

class UpdateNameError extends UpdateNameState {
  final String message;
  UpdateNameError(this.message);
}