import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/user_repository.dart';
import 'package:shopesapp/translation/locale_keys.g.dart';

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

    Map<String, dynamic>? response = await UserRepository().updateUser(
        id: id, name: name, password: password, phoneNumber: phoneNumber);
    if (response == null || response["message"] != "Done") {
      emit(UpdateUserFailed(
          message: response == null
              ? LocaleKeys.update_user_failed.tr()
              : response["message"]));
    } else {
      globalSharedPreference.setString("name", name);
      globalSharedPreference.setString("phoneNumber", phoneNumber);
      emit(UpdateUserSucceed());
    }
  }
}
