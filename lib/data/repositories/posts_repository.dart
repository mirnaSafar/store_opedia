import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';

class PostsRepository {
  Future<Map<String, dynamic>?> getPosts() async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    try {
      response = await http.get(Uri.parse(ENDPOINT + "/posts"), headers: {
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

  Future<String> deletePost({required String postID}) async {
    http.Response response;
    response = await http.delete(
      Uri.parse(ENDPOINT + '/delete/$postID'),
      headers: <String, String>{
        'Content-Type': 'application/json; ',
      },
    );
    if (response.statusCode == 200) {
      return "Success";
    }
    return "Failed";
  }

  Future<String> updatePost(
      {required String postID,
      required String shopID,
      required String title,
      required String description,
      required List<String>? postImages,
      required String category,
      required String productPrice}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "postID": postID,
      "shopID": shopID,
      "title": title,
      "description": description,
      "postImages": postImages ?? "noProductImage",
      "category": category,
      "productPrice": productPrice
    };
    response = await http.put(
      Uri.parse(ENDPOINT + '/posts/updatePosts'),
      body: jsonEncode(requestBody),
      headers: <String, String>{
        'Content-Type': 'application/json; ',
      },
    );
    if (response.statusCode == 205) {
      return "Success";
    }
    return "Failed";
  }

  Future<String> addPost(
      {required String shopID,
      required String title,
      required String description,
      required List<String>? postImages,
      required String category,
      required String productPrice}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "shopID": shopID,
      "title": title,
      "description": description,
      "postImages": postImages ?? "noProductImage",
      "category": category,
      "productPrice": productPrice,
      "rate": 0,
      "isFavorit": false
    };
    response = await http.post(
      Uri.parse(ENDPOINT + '/posts/addPost'),
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
