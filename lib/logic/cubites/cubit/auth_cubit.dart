import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_state.dart';
import 'package:shopesapp/main.dart';
import '../../../data/models/shop.dart';
import '../../../data/models/user.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  User? user;
  Shop? shop;

//user signin
  Future userSignUp(String userName, String email, String password,
      String phoneNumber) async {
    emit(AuthProgress());

    Map<String, dynamic>? response = await AuthRepository()
        .userSignUp(userName, email, password, phoneNumber);

    if (response == null || response["message"] != "User was Created") {
      emit(AuthFailed(response == null
          ? "Signup Failed  Check your internet connection"
          : response["message"]));
    } else {
      user = User.fromMap(response);

      AuthRepository().saveUser(user: user!);
      emit(UserSignedUp());
    }
  }

//Owner signin
  Future ownerSignUp({
    required String ownerName,
    required String email,
    required String password,
    required String phoneNumber,
    required String storeLocation,
    required String storeCategory,
    required String startWorkTime,
    required String endWorkTime,
    required String storeName,
    required String shopPhoneNumber,
  }) async {
    emit(AuthProgress());

    Map<String, dynamic>? response = await AuthRepository().ownerSignUp(
      ownerName: ownerName,
      password: password,
      phoneNumber: phoneNumber,
      email: email,
      storeName: storeName,
      storeLocation: storeLocation,
      storeCategory: storeCategory,
      startWorkTime: startWorkTime,
      endWorkTime: endWorkTime,
      shopPhoneNumber: shopPhoneNumber,
    );
    if (response == null || response["message"] != "Owner was Created") {
      emit(AuthFailed(response == null
          ? "Signup Failed  Check your internet connection"
          : response["message"]));
    } else {
      shop = Shop.fromMap(response);
      AuthRepository().saveOwnerAndShop(shop: shop!);
      emit(OwnerSignedUp());
    }
  }

  Future login(String email, String password) async {
    emit(AuthProgress());

    Map<String, dynamic>? response =
        await AuthRepository().login(email: email, password: password);

    if (response!["message"] == "user auth succeded") {
      user = User.fromMap(response);

      AuthRepository().saveUser(user: user!);
      emit(UserLoginedIn());
    } else if (response["message"] == "owner auth succeded") {
      String ownerID = response["ownerID"];

      saveOwnerID(ownerID: ownerID);

      emit(OwnerWillSelectStore());
    } else {
      emit(AuthFailed(response == null
          ? "Login Failed Check your internet connection"
          : response['message']));
    }
  }

  void ownerBecomeUser() {
    emit(AuthProgress());

    globalSharedPreference.setString("mode", "user");
    globalSharedPreference.remove("shopPhoneNumber");
    globalSharedPreference.remove("shopProfileImage");
    globalSharedPreference.remove("shopCoverImage");
    globalSharedPreference.remove("numberOfFollowers");
    globalSharedPreference.remove("socialUrl");
    globalSharedPreference.remove("rate");
    globalSharedPreference.remove("shopDescription");
    globalSharedPreference.remove("shopCategory");
    globalSharedPreference.remove("location");
    globalSharedPreference.remove("startWorkTime");
    globalSharedPreference.remove("endWorkTime");
    globalSharedPreference.remove("shopID");

    emit(UserLoginedIn());
  }

  void deleteCurrentShop() {
    globalSharedPreference.remove("shopPhoneNumber");
    globalSharedPreference.remove("shopProfileImage");
    globalSharedPreference.remove("shopCoverImage");
    globalSharedPreference.remove("numberOfFollowers");
    globalSharedPreference.remove("socialUrl");
    globalSharedPreference.remove("rate");
    globalSharedPreference.remove("shopDescription");
    globalSharedPreference.remove("shopCategory");
    globalSharedPreference.remove("location");
    globalSharedPreference.remove("startWorkTime");
    globalSharedPreference.remove("endWorkTime");
    globalSharedPreference.remove("shopID");
    // emit(OwnerWithoutShop());
  }

  void userBecomeOwner() {
    if (globalSharedPreference.getString("mode") == "user") {
      emit(OwnerLoginedIn());
    }
  }

  Future<void> autoLogIn() async {
    String? mode = globalSharedPreference.getString("mode");

    if (mode == null) {
      emit(NoAuthentication());
    } else if (mode == "user") {
      emit(UserLoginedIn());
    } else {
      emit(OwnerLoginedIn());
    }
  }

  void selectedShop() {
    emit(OwnerLoginedIn());
  }

  void saveOwnerID({required String ownerID}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString("ID", ownerID);
  }

  Future<void> logOut() async {
    user = null;
    shop = null;
    await AuthRepository().deleteInfo();
    emit(NoAuthentication());
  }
}
