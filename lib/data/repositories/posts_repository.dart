import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';
import 'package:shopesapp/data/models/shop.dart';

class PostsRepository {
  Future<String?> sendPostRating(
      String ownerId, String shopId, String postId, double rate) async {
    http.Response response;

    try {
      response =
          await http.post(Uri.http(ENDPOINT, "/$ownerId/$shopId/$postId"),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode({'postRate': rate}));
    } catch (e) {
      return null;
    }
    if (response.statusCode == 200) {
      return 'Success';
    }
    return null;
  }

  Future<Map<String, dynamic>?> getShopPosts({
    required String shopID,
    required String ownerID,
  }) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    Map<String, dynamic> requestBody = {
      "id": ownerID,
      "shopID": shopID,
    };
    try {
      response = await http.post(
          Uri.http(ENDPOINT, "/show/posts/owner/$shopID"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      return null;
    }
    if (response.statusCode == 200) {
      parsedResult = jsonDecode(response.body);
      return parsedResult;
    }
    return null;
  }

  Future<String> deletePost(
      {required String postID,
      required String shopID,
      required String ownerID}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "id": ownerID,
      "shopID": shopID,
      "postID": postID,
    };
    response = await http.delete(
      Uri.http(ENDPOINT, '/delete/post/$postID'),
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

  Future<String> updatePost(
      {required String postID,
      required String ownerID,
      required String shopID,
      required String name,
      required String description,
      required String? photos,
      required String price}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "id": ownerID, //ownerID
      "name": name,
      "description": description,
      "photos": photos ?? "noProductImage",
      "price": price
    };
    response = await http.put(
      Uri.http(ENDPOINT, '/profile/post/$postID'),
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

  Future<String> addPost(
      {required String shopeID,
      required String ownerID,
      required String name,
      required String description,
      required String? photos,
      required String category,
      required String price}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "id": ownerID, //ownerID
      "shopID": shopeID,
      "name": name,
      "description": description,
      "photos": photos ?? "noProductImage",
      //    "category": category,
      "price": price,
    };
    response = await http.post(
      Uri.http(ENDPOINT, '/AddPost/$ownerID'),
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
