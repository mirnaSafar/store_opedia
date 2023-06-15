import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/constant/endpoint.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/models/user.dart';

import '../models/owner.dart';

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
    //print(requestBody);
    var uri = Uri.https(ENDPOINT, "/users/signup");

    try {
      response = await http.post(uri,
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return null;
    }
    if (response.statusCode == 200 || response.statusCode == 203) {
      Map<String, dynamic> parsedBody = jsonDecode(response.body);

      return parsedBody;
    }
    return null;
  }

  Future<Map<String, dynamic>?> ownerSignUp(
    String ownerName,
    String email,
    String password,
    String phoneNumber,
    Shop currentShop,
  ) async {
    http.Response response;
    Map<String, dynamic> requestBody;
    requestBody = {
      "name": ownerName,
      "emil": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "currentShop": currentShop,
    };
    //print(requestBody);
    var uri = Uri.https(ENDPOINT, "/owners/signup");

    try {
      response = await http.post(uri,
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return null;
    }
    if (response.statusCode == 201 || response.statusCode == 2002) {
      Map<String, dynamic> parsedBody = jsonDecode(response.body);

      return parsedBody;
    }
    return null;
  }

  Future<Map<String, dynamic>?> login(
      {required String email, required String password}) async {
    User user;
    Owner owner;
    http.Response response;
    Map<String, dynamic> requestBody;
    Map<String, dynamic> parsedResult;
    requestBody = {"email": email, "password": password};
    try {
      response = await http.post(Uri.parse(ENDPOINT + "/login"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      return null;
    }
    parsedResult = jsonDecode(response.body);

    if (response.statusCode == 205) {
      //normal user
      user = User.fromMap(parsedResult['user']);
      String timeOfExpire =
          DateTime.now().add(const Duration(days: 2)).toIso8601String();

      parsedResult["expire"] = timeOfExpire;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("expire", timeOfExpire);

      saveUser(user: user);
    }
    // owner and  first shop
    else {
      owner = Owner.fromMap(parsedResult['owner']);
      String timeOfExpire =
          DateTime.now().add(const Duration(days: 2)).toIso8601String();
      parsedResult["expire"] = timeOfExpire;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("expire", timeOfExpire);

      saveOwner(owner: owner);
    }

    return (parsedResult);
  }

  Future<Map<String, dynamic>?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? id, userName, email, expire, password, phoneNumber;

    id = prefs.getString("id");
    email = prefs.getString("email");
    phoneNumber = prefs.getString("phoneNumber");
    userName = prefs.getString("userName");
    password = prefs.getString("password");
    expire = prefs.getString("expire");

    if (id != null &&
        email != null &&
        expire != null &&
        password != null &&
        phoneNumber != null &&
        userName != null) {
      return {
        "user": User(
            email: email,
            id: id,
            password: password,
            phoneNumber: phoneNumber,
            name: userName),
        "expire": expire
      };
    }
    return null;
  }

  Future<Map<String, dynamic>?> getStoredOwner() async {
    final prefs = await SharedPreferences.getInstance();
    String? id, ownerName, email, expire, password, phoneNumber, jsonShop;
    Shop currentShop;

    jsonShop = prefs.getString("currentShope");
    Map<String, dynamic> map = jsonDecode(jsonShop!);
    currentShop = Shop.fromMap(map);
    id = prefs.getString("id");
    email = prefs.getString("email");
    phoneNumber = prefs.getString("phoneNumber");
    ownerName = prefs.getString("ownerName");
    password = prefs.getString("password");
    expire = prefs.getString("expire");

    if (id != null &&
        email != null &&
        expire != null &&
        password != null &&
        phoneNumber != null &&
        ownerName != null) {
      return {
        "Owner": Owner(
            email: email,
            id: id,
            password: password,
            phoneNumber: phoneNumber,
            name: ownerName,
            currentShop: currentShop),
        "expire": expire
      };
    }
    return null;
  }

  Future<void> deleteInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String?> getAuthMode() async {
    final prefs = await SharedPreferences.getInstance();
    String? mode = prefs.getString("mode");
    return mode;
  }

  void saveOwner({required Owner owner}) async {
    Shop shop;
    shop = Shop(
        shopID: owner.currentShop.shopID,
        shopCategory: owner.currentShop.shopCategory,
        shopName: owner.currentShop.shopName,
        shopDescription: owner.currentShop.shopDescription,
        socialUrl: owner.currentShop.socialUrl,
        shopCoverImage: owner.currentShop.shopCoverImage,
        shopProfileImage: owner.currentShop.shopProfileImage,
        location: owner.currentShop.location,
        timeOfWorking: owner.currentShop.timeOfWorking,
        rate: owner.currentShop.rate,
        owner: owner.toMap());

    String jsonShop = jsonEncode(shop);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", owner.id);
    await prefs.setString("email", owner.email);
    await prefs.setString("phoneNumber", owner.phoneNumber);
    await prefs.setString("userName", owner.name);
    await prefs.setString("password", owner.password);
    await prefs.setString("currentShop", jsonShop);
    await prefs.setString("mode", "owner");
  }

  void saveUser({required User user}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", user.id);
    await prefs.setString("email", user.email);
    await prefs.setString("phoneNumber", user.phoneNumber);
    await prefs.setString("userName", user.name);
    await prefs.setString("password", user.password);
    await prefs.setString("mode", "user");
  }
}
