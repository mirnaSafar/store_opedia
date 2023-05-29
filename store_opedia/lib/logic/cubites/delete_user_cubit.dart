import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/delete_user_repository.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserRepository deleteUserRepository;
  DeleteUserCubit(this.deleteUserRepository) : super(DeleteUserInitial());

  Future deleteUser({required String id}) async {
    emit(DeleteUserProgress());
    String response = await deleteUserRepository.deleteUser(id: id);
    if (response == "Field") {
      emit(DeleteUserFailed(
          message:
              "Failed to delet the user , Check your internet connection"));
    } else if (response == "Success") {
      emit(DeleteUserSucceed());
    }
  }
}
