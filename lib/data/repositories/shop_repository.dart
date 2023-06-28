import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';

class ShopRepository {
  Future<Map<String, dynamic>?> getOwnerShpos(
      {required String? ownerID}) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    Map<String, dynamic> requestBody = {
      "ownerID": ownerID,
    };
    try {
      response = await http.post(Uri.http(ENDPOINT, "/shops"),
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

//Demo test offline
  Map<String, dynamic>? getOwnerShposTest() {
    return {
      "message": "Succeed",
      "shops": [
        {
          "ownerID": "123",
          "ownerName": "demo",
          "ownerEmail": "email@gmail.com",
          "ownerPhoneNumber": "0951931846",
          "shopID": "2",
          "shopCategory": "Clothes Categories",
          "shopName": "Joserf store",
          "shopPhoneNumber": "0912345678",
          "location": "Homs",
          "startWorkTime": "12:00:45.893",
          "endWorkTime": "12:00:45.893",
          "shopProfileImage": "url",
          "shopCoverImage": "url",
          "shopDescription": "desc",
          "socialUrl": "test",
          "rate": 4,
          "followesNumber": 100,
        },
        {
          "ownerID": "1234",
          "ownerName": "demo",
          "ownerEmail": "anas2@gmail.com",
          "ownerPhoneNumber": "0951931846",
          "shopID": "1",
          "shopCategory": "sport Categories",
          "shopName": "Demo Store",
          "shopPhoneNumber": "0912345678",
          "location": "Homs",
          "startWorkTime": "12:00:45.893",
          "endWorkTime": "12:00:45.893",
          "shopProfileImage": "url",
          "shopCoverImage": "url",
          "shopDescription": "desc",
          "socialUrl": "test",
          "rate": 4,
          "followesNumber": 100,
        },
      ]
    };
  }

  Future<String> addShop({
    required Map<String, dynamic> owner,
    required String shopName,
    required String shopDescription,
    required String? shopProfileImage,
    required String? shopCoverImage,
    required String shopCategory,
    required String location,
    required String endWorkTime,
    required String startWorkTime,
    required List<String> socialUrl,
    required String shopPhoneNumber,
  }) async {
    http.Response response;
    String ownerID = owner["id"];
    Map<String, dynamic> requestBody = {
      "owner": owner,
      "shopName": shopName,
      "shopDescription": shopDescription,
      "shopProfileImage": shopProfileImage ?? "noImage",
      "shopCoverImage": shopCoverImage ?? "noImage",
      "shopCategory": shopCategory,
      "location": location,
      "startWorkTime": startWorkTime,
      "endWorkTime": endWorkTime,
      "socialUrl": socialUrl,
      "rate": 0,
      "isFavorit": false,
      "isFollow": false,
      "shopPhoneNumber": shopPhoneNumber,
    };
    try {
      response = await http.post(Uri.http(ENDPOINT, "/shops/addShop/$ownerID"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      return "Faild";
    }
    if (response.statusCode == 205) {
      return "Success";
    }
    return "Faild";
  }

  Future<String> deleteShop({required String shopID}) async {
    http.Response response;
    try {
      response = await http
          .delete(Uri.http(ENDPOINT + "/shops/delete/$shopID"), headers: {
        'Content-Type': 'application/json',
      });
    } catch (e) {
      return "Faild";
    }
    if (response.statusCode == 200) {
      return "Success";
    }
    return "Faild";
  }

  Future<String> updateShop({
    required String shopID,
    required String shopName,
    required String shopDescription,
    required String? shopProfileImage,
    required String? shopCoverImage,
    required String shopCategory,
    required String location,
    required String endWorkTime,
    required String startWorkTime,
    required List<String> socialUrl,
    required String shopPhoneNumber,
  }) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "shopName": shopName,
      "shopDescription": shopDescription,
      "shopProfileImage": shopProfileImage ?? "noImage",
      "shopCoverImage": shopCoverImage ?? "noImage",
      "shopCategory": shopCategory,
      "location": location,
      "startWorkTime": startWorkTime,
      "endWorkTime": endWorkTime,
      "socialUrl": socialUrl,
      "shopPhoneNumber": shopPhoneNumber,
    };
    try {
      response = await http.put(Uri.http(ENDPOINT, "/shops/updateShop/$shopID"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      return "Faild";
    }
    if (response.statusCode == 205) {
      return "Success";
    }
    return "Faild";
  }

  Future<Map<String, dynamic>?> getRelatedShops(
      {required String location}) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    try {
      response = await http
          .get(Uri.http(ENDPOINT, "/shops/locations/$location"), headers: {
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
