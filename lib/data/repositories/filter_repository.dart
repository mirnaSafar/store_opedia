import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';

class FilterRepository {
  Future<Map<String, dynamic>?> getPostsFilteredWithCategory(
      {required String category}) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    try {
      response = await http
          .get(Uri.parse(ENDPOINT + "/posts/categories/$category"), headers: {
        'Content-Type': 'application/json',
      });
    } catch (e) {
      return null;
    }
    if (response.statusCode == 205) {
      parsedResult = jsonDecode(response.body);
      return parsedResult;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getPostsFilteredWithRatings() async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    try {
      response =
          await http.get(Uri.parse(ENDPOINT + "/posts/ratings"), headers: {
        'Content-Type': 'application/json',
      });
    } catch (e) {
      return null;
    }
    if (response.statusCode == 205) {
      parsedResult = jsonDecode(response.body);
      return parsedResult;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getPostsFilteredWithLocation(
      {required String location}) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    try {
      response = await http
          .get(Uri.parse(ENDPOINT + "/posts/location/$location"), headers: {
        'Content-Type': 'application/json',
      });
    } catch (e) {
      return null;
    }
    if (response.statusCode == 205) {
      parsedResult = jsonDecode(response.body);
      return parsedResult;
    }
    return null;
  }
}
