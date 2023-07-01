import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';

class UserRepository {
  Future<Map<String, dynamic>?> updateUser(
      {required String id,
      required String userName,
      required String email,
      required String phoneNumber}) async {
    Map<String, dynamic> parsedResult;
    Map<String, dynamic> requestBody = {
      "id": id,
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber
    };
    http.Response response;
    try {
      response = await http.put(
        Uri.http(ENDPOINT, '/$id'),
        body: jsonEncode(requestBody),
        headers: <String, String>{'Content-Type': 'application/json;'},
      );
      parsedResult = jsonDecode(response.body);
      return (parsedResult);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String> deleteUser({required String id}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {"id": id};
    response = await http.delete(
      Uri.http(ENDPOINT, '/$id'),
      body: jsonEncode(requestBody),
      headers: <String, String>{
        'Content-Type': 'application/json; ',
      },
    );
    if (response.statusCode == 200) {
      return "Success";
    }
    return "Failed";
  }
}
