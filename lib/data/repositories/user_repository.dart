import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';

class UserRepository {
  Future<String?> updateUser(
      {required String id,
      required String name,
      required String password,
      required String phoneNumber}) async {
    Map<String, dynamic> requestBody = {
      "id": id,
      "userName": name,
      "password": password,
      "phoneNumber": phoneNumber
    };
    http.Response response;
    try {
      response = await http.put(
        Uri.http(ENDPOINT, '/profile/$id'),
        body: jsonEncode(requestBody),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return "Success";
      }
    } catch (e) {
      print(e);
      return "Failed";
    }
    return "Failed";
  }

  Future<String> deleteUser({required String id}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {"id": id};
    response = await http.delete(
      Uri.http(ENDPOINT, '/delete/$id'),
      body: jsonEncode(requestBody),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return "Success";
    }
    return "Failed";
  }
}
