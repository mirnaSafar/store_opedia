import 'dart:async';
import 'dart:core';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/owner.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';
import 'package:shopesapp/logic/cubites/auth_state.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_state.dart';
import '../../data/models/shop.dart';
import '../../data/models/user.dart';

class AuthCubit extends Cubit<AuthState> {
  late Timer _authTimer;
  final AuthRepository repo;
  late User? user;
  late Shop? currentShop;
  late Owner? owner;
  late DateTime _expire;
  late String? _mode;

  AuthCubit(this.repo) : super(AuthInitialState()) {
    autoLogin();
  }
//user signin
  Future userSignUp(String userName, String email, String password,
      String phoneNumber) async {
    emit(AuthProgress());

    Map<String, dynamic>? response =
        await repo.userSignUp(userName, email, password, phoneNumber);

    if (response == null || response["message"] != "User was Created") {
      emit(AuthFailed(response == null
          ? "Signup Failed  Check your internet connection"
          : response["message"]));
    } else if (response["message"] == "Email Already Exists") {
      emit(AuthFailed("Email Already Exists"));
    } else {
      emit(UserSignedUp());
    }
  }

//Owner signin
  Future ownerSignUp(String ownerName, String email, String password,
      String phoneNumber, Shop currentShop) async {
    emit(AuthProgress());

    Map<String, dynamic>? response = await repo.ownerSignUp(
        ownerName, email, password, phoneNumber, currentShop);

    if (response == null || response["message"] != "Owner was Created") {
      emit(AuthFailed(response == null
          ? "Signup Failed  Check your internet connection"
          : response["message"]));
    } else if (response["message"] == "Email Already Exists") {
      emit(AuthFailed("Email Already Exists"));
    } else {
      emit(OwnerSignedUp());
    }
  }

  Future login(String email, String password) async {
    emit(AuthProgress());

    Map<String, dynamic>? response =
        await repo.login(email: email, password: password);
    if (response!["statusCode"] == 205 &&
        response != null &&
        response["message"] == "auth succeded") {
      _expire = DateTime.parse(response["expire"] as String);
      autoLogout(_expire.difference(DateTime.now()).inSeconds);

      user = User.fromMap(response["user"]);
      emit(UserLoginedIn(user: user!));
    } else if (response != null && response["message"] == "auth succeded") {
      _expire = DateTime.parse(response["expire"] as String);
      autoLogout(_expire.difference(DateTime.now()).inSeconds);
      owner = Owner.fromMap(response["owner"]);

      emit(OwnerLoginedIn(owner: owner!));
    } else {
      emit(AuthFailed(response == null
          ? "Login Failed Check your internet connection"
          : response['message']));
    }
  }

  void autoLogout(int time) {
    _authTimer = Timer(Duration(seconds: time), logOut);
  }

  void autoLogin() {
    repo.getAuthMode().then((value) {
      _mode = value;
      if (_mode == "user") {
        repo.getStoredUser().then((mapofUserAndExpire) {
          if (mapofUserAndExpire == null) {
            emit(AuthNoToken());
            return;
          } else {
            _expire = DateTime.parse(mapofUserAndExpire["expire"] as String);
          }
          if (_expire.isBefore(DateTime.now())) {
            emit(AuthNoToken());

            return;
          }
          autoLogout(_expire.difference(DateTime.now()).inSeconds);

          user = mapofUserAndExpire["user"] as User;

          emit(UserLoginedIn(user: user!));
        });
      } else {
        repo.getStoredOwner().then((mapofOwnerAndExpire) {
          if (mapofOwnerAndExpire == null) {
            emit(AuthNoToken());
            return;
          } else {
            _expire = DateTime.parse(mapofOwnerAndExpire["expire"] as String);
          }
          if (_expire.isBefore(DateTime.now())) {
            emit(AuthNoToken());

            return;
          }
          autoLogout(_expire.difference(DateTime.now()).inSeconds);

          owner = mapofOwnerAndExpire["owner"] as Owner;
          currentShop = owner?.currentShop;

          emit(OwnerLoginedIn(owner: owner!));
        });
      }
    });
  }

  Future<void> logOut() async {
    if (_mode == "user") {
      await repo.deleteStoredUser();
      user = null;
    } else {
      await repo.deleteStoredOwner();
      owner = null;
    }
    _authTimer.cancel();
    emit(AuthNoToken());
  }

  dynamic getInfo() {
    if (_mode == "user") {
      repo.getStoredUser().then((value) {
        user = value!['user'] as User;
        return User.from(user!);
      });
    } else {
      repo.getStoredOwner().then((value) {
        owner = value!['owner'] as Owner;
        return Owner.from(owner!);
      });
    }
  }
}
