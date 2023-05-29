import 'dart:async';
import 'dart:core';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';
import 'package:shopesapp/logic/cubites/user_state.dart';
import '../../data/models/user.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  late Timer _authTimer;
  final AuthRepository repo;
  late User? user;
  late DateTime _expire;

  UserAuthCubit(this.repo) : super(UserAuthInitialState()) {
    startupLogin();
  }

  Future signin(String userName, String email, String password,
      String phoneNumber) async {
    emit(UserAuthProgress());

    Map<String, dynamic>? response =
        await repo.signin(userName, email, password, phoneNumber);

    if (response == null || response["message"] != "User was Created") {
      emit(UserAuthFailed(response == null
          ? "Signup Failed  Check your internet connection"
          : response["message"]));
    } else if (response["message"] == "Email Already Exists") {
      emit(UserAuthFailed("Email Already Exists"));
    } else {
      emit(UserAuthSignedUp());
    }
  }

  Future login(String email, String password) async {
    emit(UserAuthProgress());

    Map<String, dynamic>? response = await repo.login(email, password);

    if (response == null || response["message"] != "auth succeded") {
      emit(UserAuthFailed(response == null
          ? "Login Failed Check your internet connection"
          : response['message']));
    } else {
      _expire = DateTime.parse(response["expire"] as String);
      autoLogout(_expire.difference(DateTime.now()).inSeconds);
      user = User.fromMap(response["user"]);

      emit(UserAuthLoginedIn(user: user!));
    }
  }

  void autoLogout(int time) {
    _authTimer = Timer(Duration(seconds: time), logOut);
  }

  void startupLogin() {
    repo.getStoredUser().then((mapofUserAndExpire) {
      if (mapofUserAndExpire == null) {
        emit(UserAuthNoToken());
        return;
      } else {
        _expire = DateTime.parse(mapofUserAndExpire["expire"] as String);
      }
      if (_expire.isBefore(DateTime.now())) {
        emit(UserAuthNoToken());

        return;
      }
      autoLogout(_expire.difference(DateTime.now()).inSeconds);

      user = mapofUserAndExpire["user"] as User;

      emit(UserAuthLoginedIn(user: user!));
    });
  }

  Future<void> logOut() async {
    await repo.deleteStoredUser();
    _authTimer.cancel();
    user = null;
    emit(UserAuthNoToken());
  }

  User getUser() {
    repo.getStoredUser().then((value) {
      user = value!['user'] as User;
    });
    return User.from(user!);
  }
}
