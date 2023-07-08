import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/user_repository.dart';
import 'package:shopesapp/main.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit() : super(DeleteUserInitial());

  Future deleteUser() async {
    emit(DeleteUserProgress());
    String id = globalSharedPreference.getString("ID")!;

    String response = await UserRepository().deleteUser(id: id);
    if (response == "Faield") {
      emit(DeleteUserFailed(
          message:
              "Failed to delet the user , Check your internet connection"));
    } else if (response == "Success") {
      emit(DeleteUserSucceed());
    }
  }
}
