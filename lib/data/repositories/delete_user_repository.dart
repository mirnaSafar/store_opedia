import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';

class DeleteUserRepository {
  Future<String> deleteUser({required String id}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {"id": id};
    response = await http.delete(
      Uri.parse(ENDPOINT + '/$id'),
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
