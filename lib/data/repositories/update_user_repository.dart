import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';

class UpdateUserRepository {
  Future<Map<String, dynamic>?> updateUser(
      {required String id,
      required String userName,
      required String email,
      required String password,
      required String phoneNumber}) async {
    Map<String, dynamic> parsedResult;
    Map<String, dynamic> requestBody = {
      "id": id,
      "userName": userName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber
    };
    http.Response response;
    try {
      response = await http.put(
        Uri.parse(ENDPOINT + '/$id'),
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
}
