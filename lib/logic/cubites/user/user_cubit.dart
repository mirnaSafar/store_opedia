import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/models/user.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';
import 'package:shopesapp/data/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.user) : super(UserInitial(null));
  User user;
// Future getUser
  Future updateUser(
      {required String id,
      required String userName,
      required String email,
      required String password,
      required String phoneNumber}) async {
    emit(UpdateUserProgress());

    Map<String, dynamic>? response = await UserRepository().updateUser(
        id: id, userName: userName, email: email, phoneNumber: phoneNumber);
    if (response == null ||
        response['message'] != 'User has been Updated successfully') {
      emit(UpdateUserFailed(
          message: response == null
              ? "Failed to Update the user , Check your internet connection"
              : response['message']));
    } else {
      saveUpdatedUser(
          userName: userName, phoneNumber: phoneNumber, password: password);
      emit(UpdateUserSucceed());
    }
  }

  void saveUpdatedUser(
      {required String userName,
      required String phoneNumber,
      required String password}) async {
    SharedPreferencesRepository.saveUpdatedUser(
        userName: userName, phoneNumber: phoneNumber, password: password);
  }

  Future deleteUser({required String id}) async {
    emit(DeleteUserProgress());
    String response = await UserRepository().deleteUser(id: id);
    if (response == "Field") {
      emit(DeleteUserFailed(
          message:
              "Failed to delet the user , Check your internet connection"));
    } else if (response == "Success") {
      emit(DeleteUserSucceed());
    }
  }
}
