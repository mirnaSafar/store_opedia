import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/constant/endpoint.dart';
import 'package:shopesapp/data/models/user.dart';

class AuthRepository {
  Future<Map<String, dynamic>?> signin(String userName, String email,
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
    if (response.statusCode == 200 || response.statusCode == 400) {
      Map<String, dynamic> parsedBody = jsonDecode(response.body);

      return parsedBody;
    }
    return null;
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    User user;
    http.Response response;
    Map<String, dynamic> requestBody;
    Map<String, dynamic> parsedResult;
    requestBody = {"email": email, "password": password};
    try {
      response = await http.post(Uri.parse(ENDPOINT + "/user/login"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      return null;
    }
    parsedResult = jsonDecode(response.body);

    if (response.statusCode == 202) {
      user = User.fromMap(parsedResult['user']);
      String timeOfExpire =
          DateTime.now().add(const Duration(days: 2)).toIso8601String();

      parsedResult["expire"] = timeOfExpire;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("id", user.id);
      await prefs.setString("email", user.email);
      await prefs.setString("expire", timeOfExpire);
      await prefs.setString("phoneNumber", user.phoneNumber);
      await prefs.setString("userName", user.userName);
      await prefs.setString("password", user.password);
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
            userName: userName),
        "expire": expire
      };
    }
    return null;
  }

  Future<void> deleteStoredUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('id');
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove("phoneNumber");
    await prefs.remove("userName");
    await prefs.remove("expire");
  }
}
