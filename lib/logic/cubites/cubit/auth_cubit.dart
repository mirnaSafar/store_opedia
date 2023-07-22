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
    if (response == null) {
      emit(AuthFailed("Signup Failed Check your internet connection"));
    } else if (response["message"] != "Owner was Created") {
      emit(AuthFailed(response["message"]));
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

    if (response == null) {
      emit(AuthFailed("Login Failed Check your internet connection"));
    }
    if (response!["message"] != "user auth succeded" &&
        response["message"] != "owner auth succeded") {
      emit(AuthFailed(response['message']));
    } else if (response["message"] == "user auth succeded") {
      user = User.fromMap(response);

      AuthRepository().saveUser(user: user!);
      emit(UserLoginedIn());
    } else if (response["message"] == "owner auth succeded") {
      String ownerID = response["ownerID"];

      saveOwnerID(ownerID: ownerID);

      emit(OwnerWillSelectStore());
    }
  }

  void userBecomeOwner() {
    globalSharedPreference.setString("mode", "owner");
    globalSharedPreference.setString("currentShop", "noShop");
    globalSharedPreference.setString("CurrentShopID", "noID");
    emit(OwnerLoginedIn());
  }

  void ownerBecomeUser() {
    emit(AuthProgress());

    globalSharedPreference.setString("mode", "user");
    globalSharedPreference.setString("currentShop", "shopDeleted");
    /*  globalSharedPreference.remove("shopPhoneNumber");
    globalSharedPreference.remove("shopProfileImage");
    globalSharedPreference.remove("shopCoverImage");
    globalSharedPreference.remove("numberOfFollowers");
    globalSharedPreference.remove("socialUrl");
    globalSharedPreference.remove("rate");
    globalSharedPreference.remove("shopDescription");
    globalSharedPreference.remove("shopCategory");
    globalSharedPreference.remove("location");
    globalSharedPreference.remove("startWorkTime");
    globalSharedPreference.remove("endWorkTime");*/

    emit(UserLoginedIn());
  }

  void deleteCurrentShop() {
    globalSharedPreference.setString("currentShop", "noShop");
    globalSharedPreference.remove("shopPhoneNumber");
    globalSharedPreference.remove("shopProfileImage");
    globalSharedPreference.remove("shopCoverImage");
    globalSharedPreference.remove("numberOfFollowers");
    globalSharedPreference.remove("socialUrl");
    globalSharedPreference.remove("rate");
    globalSharedPreference.remove("shopDescription");
    globalSharedPreference.remove("shopCategory");
    globalSharedPreference.remove("location");
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
    globalSharedPreference.setString("currentShop", "ShopSelected");

    emit(OwnerLoginedIn());
  }

  void saveOwnerID({required String ownerID}) async {
    await globalSharedPreference.setString("ID", ownerID);
    await globalSharedPreference.setString("shopID", "noID");
  }

  Future<void> logOut() async {
    user = null;
    shop = null;
    await AuthRepository().deleteInfo();
    emit(NoAuthentication());
  }
}
