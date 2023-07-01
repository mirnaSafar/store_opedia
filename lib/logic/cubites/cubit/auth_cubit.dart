import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';
import 'package:shopesapp/logic/cubites/cubit/auth_state.dart';
import '../../../data/models/shop.dart';
import '../../../data/models/user.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repo) : super(AuthInitialState());

  final AuthRepository repo;
  User? user;
  Shop? shop;

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
    } else {
      user = User.fromMap(response);
      repo.saveUser(user: user!);
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

    Map<String, dynamic>? response = await repo.ownerSignUp(
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
      repo.saveOwnerAndShop(shop: shop!);
      emit(OwnerSignedUp());
    }
  }

  Future login(String email, String password) async {
    emit(AuthProgress());

    Map<String, dynamic>? response =
        await repo.login(email: email, password: password);

    if (response!["message"] == "user auth succeded") {
      user = User.fromMap(response);
      repo.saveUser(user: user!);
      emit(UserLoginedIn());
    } else if (response["message"] == "owner auth succeded") {
      String ownerID = response["ownerID"];

      saveOwnerID(ownerID: ownerID);

      emit(OwnerLoginedIn());
    } else {
      emit(AuthFailed(response == null
          ? "Login Failed Check your internet connection"
          : response['message']));
    }
  }

  Future<void> autoLogIn() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? mode = _pref.getString("mode");
    String? ownerID = _pref.getString("OwnerID");
    if (ownerID == null && mode == null) {
      emit(NoAuthentication());
    } else if (mode == null && ownerID != null) {
      emit(OwnerLoginedIn());
    } else if (mode == "user") {
      repo.getStoredUser().then((sortedUser) {
        user = sortedUser!["user"] as User;
        emit(UserLoginedIn());
      });
    } else {
      repo.getStoredOwnerAndShop().then((sortedShop) {
        shop = sortedShop!["shop"] as Shop;
        emit(OwnerLoginedIn());
      });
    }
  }

  void selectedShop() {
    emit(OwnerLogiedInWithShop());
  }

  Shop getOwnerAndShop() {
    repo.getStoredOwnerAndShop().then((value) {
      shop = value!['owner'] as Shop;
    });
    return Shop.from(shop!);
  }

  void saveOwnerID({required String ownerID}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString("ID", ownerID);
  }

  Future<void> logOut() async {
    user = null;
    shop = null;
    await repo.deleteInfo();
    emit(NoAuthentication());
  }
}
