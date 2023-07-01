import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/data/repositories/user_repository.dart';
import '../../../data/models/user.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  // UserRepository updateUserRepository;
  // User user;
  UpdateUserCubit() : super(UpdateUserInitial());

  Future updateUser(User user) async {
    emit(UpdateUserProgress());

    Map<String, dynamic>? response = await UserRepository().updateUser(
        id: user.id,
        userName: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber);
    if (response == null ||
        response['message'] != 'User has been Updated successfully') {
      emit(UpdateUserFailed(
          message: response == null
              ? "Failed to Update the user , Check your internet connection"
              : response['message']));
    } else {
      saveUpdatedUser(
          userName: user.name, phoneNumber: user.phoneNumber, passwordLenght: 8
          // user.password.length
          );
      emit(UpdateUserSucceed());
    }
  }

  void saveUpdatedUser(
      {required String userName,
      required String phoneNumber,
      required int passwordLenght}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("userName", userName);
    _pref.setString("phoneNumber", phoneNumber);
    _pref.setInt("passwordLength", passwordLenght);
  }
}
