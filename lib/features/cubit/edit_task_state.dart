abstract class EditTaskState {}

class EditTaskInitial extends EditTaskState {}

class EditTaskLoading extends EditTaskState {}

class EditTaskSuccess extends EditTaskState {}

class EditTaskFailure extends EditTaskState {
  final String errorMessage;
  EditTaskFailure(this.errorMessage);
}