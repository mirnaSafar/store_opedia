import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/user_repository.dart';

import '../../../data/repositories/shared_preferences_repository.dart';
import '../../../main.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial());

  Future updateUser(
      {required String name,
      required String phoneNumber,
      required String password,
      required String id}) async {
    emit(UpdateUserProgress());

    String? response = await UserRepository().updateUser(
        id: id, name: name, password: password, phoneNumber: phoneNumber);
    if (response == null || response == "Failed") {
      emit(UpdateUserFailed(
          message: response ??
              "Failed to Update the user , Check your internet connection"));
    } else {
      globalSharedPreference.setString("name", name);
      globalSharedPreference.setString("phoneNumber", phoneNumber);
      emit(UpdateUserSucceed());
    }
  }
}
