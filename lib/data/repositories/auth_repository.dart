import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/constant/endpoint.dart';
import 'package:shopesapp/data/models/owner.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/models/user.dart';
import 'package:shopesapp/logic/cubites/cubit/owner_cubit.dart';

class AuthRepository {
  Future<Map<String, dynamic>?> userSignUp(String userName, String email,
      String password, String phoneNumber) async {
    http.Response response;
    Map<String, dynamic> requestBody;
    requestBody = {
      "name": userName,
      "emil": email,
      "password": password,
      "phoneNumber": phoneNumber
    };
    var uri = Uri.http(ENDPOINT, "/users/signup");

    try {
      response = await http.post(uri,
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return null;
    }
    if (response.statusCode == 200 || response.statusCode == 203) {
      Map<String, dynamic> parsedResult = jsonDecode(response.body);

      return parsedResult;
    }
    return null;
  }

  Future<Map<String, dynamic>?> ownerSignUp({
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
    http.Response response;
    Map<String, dynamic> requestBody;
    requestBody = {
      "name": ownerName,
      "emil": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "storeName": storeName,
      "storeLocation": storeLocation,
      "storeCategory": storeCategory,
      "startWorkTime": startWorkTime,
      "endWorkTime": endWorkTime,
      "shopPhoneNumber": shopPhoneNumber
    };

    var uri = Uri.http(ENDPOINT, "/owners/signup");

    try {
      response = await http.post(uri,
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return null;
    }
    if (response.statusCode == 201 || response.statusCode == 202) {
      Map<String, dynamic> parsedResult = jsonDecode(response.body);
      BlocListener<OwnerCubit, OwnerState>(
        listener: (context, state) {
          Owner owner = Owner.fromMap(requestBody);
          OwnerCubit(owner: owner);
        },
      );
      return parsedResult;
    }
    return null;
  }

  Future<Map<String, dynamic>?> login(
      {required String email, required String password}) async {
    http.Response response;
    Map<String, dynamic> requestBody;
    Map<String, dynamic> parsedResult;
    requestBody = {
      "email": email,
      "password": password,
    };
    try {
      var uri = Uri.http(ENDPOINT, "/login");
      response = await http.post(
        uri,
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      return null;
    }
    if (response.statusCode == 200) {
      parsedResult = jsonDecode(response.body);
      return parsedResult;
    }

    return null;
  }

  Future<Map<String, dynamic>?> verifyPassword(
      {required String password}) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    Map<String, dynamic> requestBody = {"password": password};
    try {
      response = await http.post(Uri.http(ENDPOINT, "/verifyPassword"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      return null;
    }
    if (response.statusCode == 200) {
      parsedResult = jsonDecode(response.body);
    } else {
      return null;
    }
    return parsedResult;
  }

  Future<Map<String, dynamic>?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? id, userName, email, phoneNumber;

    id = prefs.getString("id");
    email = prefs.getString("email");
    phoneNumber = prefs.getString("phoneNumber");
    userName = prefs.getString("userName");
    if (id != null &&
        email != null &&
        phoneNumber != null &&
        userName != null) {
      return {
        "user": User(
          email: email,
          id: id,
          phoneNumber: phoneNumber,
          name: userName,
        ),
      };
    }
    return null;
  }

  Future<Map<String, dynamic>?> getStoredOwnerAndShop() async {
    final prefs = await SharedPreferences.getInstance();
    String? ownerID,
        ownerName,
        ownerEmail,
        ownerPhoneNumber,
        shopCategory,
        shopID,
        endWorkTime,
        location,
        shopName,
        shopPhoneNumber,
        shopProfileImage,
        shopCoverImage,
        shopDescription,
        socialUrl,
        startWorkTime;
    int? followesNumber, rate;
    socialUrl = prefs.getString("socialUrl");
    rate = prefs.getInt("rate");
    followesNumber = prefs.getInt("followesNumber");
    shopDescription = prefs.getString("shopDescription");
    shopCoverImage = prefs.getString("shopCoverImage");
    shopPhoneNumber = prefs.getString("shopPhoneNumber");
    shopProfileImage = prefs.getString("shopProfileImage");
    ownerID = prefs.getString("ID");
    ownerEmail = prefs.getString("ownerEmail");
    ownerPhoneNumber = prefs.getString("ownerPhoneNumber");
    ownerName = prefs.getString("ownerName");
    shopID = prefs.getString("shopID");
    shopName = prefs.getString("shopName");
    shopCategory = prefs.getString("shopCategory");
    endWorkTime = prefs.getString("endWorkTime");
    startWorkTime = prefs.getString("startWorkTime");
    location = prefs.getString("location");

    if (ownerID != null &&
        ownerEmail != null &&
        ownerPhoneNumber != null &&
        ownerName != null &&
        shopID != null &&
        shopCategory != null &&
        startWorkTime != null &&
        endWorkTime != null &&
        location != null &&
        shopName != null) {
      return {
        "shop": Shop(
          ownerEmail: ownerEmail,
          ownerID: ownerID,
          ownerPhoneNumber: ownerPhoneNumber,
          ownerName: ownerName,
          shopCategory: shopCategory,
          shopID: shopID,
          startWorkTime: startWorkTime,
          endWorkTime: endWorkTime,
          location: location,
          shopName: shopName,
          shopPhoneNumber: shopPhoneNumber,
          shopProfileImage: shopProfileImage,
          shopCoverImage: shopCoverImage,
          shopDescription: shopDescription,
          followesNumber: followesNumber,
          rate: rate,
          socialUrl: socialUrl,
        ),
      };
    }
    return null;
  }

  Future<void> deleteInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void saveOwnerAndShop({required Shop shop}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("shopPhoneNumber", shop.shopPhoneNumber ?? "null");
    await prefs.setString("shopProfileImage", shop.shopProfileImage ?? "null");
    await prefs.setString("shopCoverImage", shop.shopCoverImage ?? "null");
    await prefs.setString("numberOfFollowers", shop.shopDescription ?? "null");
    await prefs.setString("socialUrl", shop.socialUrl ?? "null");
    await prefs.setInt("rate", shop.rate ?? 0);
    await prefs.setInt("followesNumber", shop.followesNumber ?? 0);
    await prefs.setString("ID", shop.ownerID);
    await prefs.setString("ownerEmail", shop.ownerEmail);
    await prefs.setString("ownerPhoneNumber", shop.ownerPhoneNumber);
    await prefs.setString("ownerName", shop.ownerName);
    await prefs.setString("shopName", shop.shopName);
    await prefs.setString("shopCategory", shop.shopCategory);
    await prefs.setString("location", shop.location);
    await prefs.setString("startWorkTime", shop.startWorkTime);
    await prefs.setString("endWorkTime", shop.endWorkTime);
    await prefs.setString("shopID", shop.shopID);
    await prefs.setString("mode", "owner");
  }

  void saveUser({required User user}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("ID", user.id);
    await prefs.setString("email", user.email);
    await prefs.setString("phoneNumber", user.phoneNumber);
    await prefs.setString("userName", user.name);
    await prefs.setString("mode", "user");
  }
}
