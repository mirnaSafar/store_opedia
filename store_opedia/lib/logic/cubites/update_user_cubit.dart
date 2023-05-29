import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/data/repositories/update_user_repository.dart';

import '../../../data/models/user.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserRepository updateUserRepository;
  late User? user;
  UpdateUserCubit(this.updateUserRepository) : super(UpdateUserInitial());

  Future updateUser(
      {required String id,
      required String userName,
      required String email,
      required String password,
      required String phoneNumber}) async {
    emit(UpdateUserProgress());

    Map<String, dynamic>? response = await updateUserRepository.updateUser(
        id: id,
        userName: userName,
        email: email,
        password: password,
        phoneNumber: phoneNumber);
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
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("userName", userName);
    _pref.setString("password", password);
    _pref.setString("phoneNumber", phoneNumber);
  }
}
