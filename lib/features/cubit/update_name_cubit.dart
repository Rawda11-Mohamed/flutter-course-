import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvmproject/features/data/repo/auth_repo_imp.dart';
import 'update_name_state.dart';

class UpdateNameCubit extends Cubit<UpdateNameState> {
  final AuthRepoImp authRepo;

  UpdateNameCubit(this.authRepo) : super(UpdateNameInitial());

  static UpdateNameCubit get(context) => BlocProvider.of<UpdateNameCubit>(context);

  Future<void> updateName(String newName) async {
    emit(UpdateNameLoading());

    if (newName.trim().isEmpty) {
      emit(UpdateNameError('Name cannot be empty'));
      return;
    }

    if (newName.trim().length < 2) {
      emit(UpdateNameError('Name must be at least 2 characters'));
      return;
    }

    try {
      await authRepo.updateUserName(newName.trim());
      emit(UpdateNameSuccess(newName.trim()));
    } on Exception catch (e) {
      emit(UpdateNameError(e.toString()));
    }
  }
}