import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';
import 'package:shopesapp/main.dart';

part 'verify_password_state.dart';

class VerifyPasswordCubit extends Cubit<VerifyPasswordState> {
  VerifyPasswordCubit() : super(VerifyPasswordInitial());

  Future verifyPassword({required String password}) async {
    emit(VerifyPasswordProgress());

    String? id = globalSharedPreference.getString("ID")!;

    String? response =
        await AuthRepository().verifyPassword(password: password, id: id);

    if (response == null || response == "MisMatched") {
      emit(VerifyPasswordFailed(
          message: response ??
              "Failed to Verify the Password , Check your internet connection"));
    } else {
      emit(VerifyPasswordSucceed());
    }
  }
}
