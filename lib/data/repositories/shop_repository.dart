import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';

class ShopRepository {
  Future<Map<String, dynamic>?> getOwnerShpos({required String ownerID}) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    try {
      response =
          await http.get(Uri.parse(ENDPOINT + "/shops/$ownerID"), headers: {
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

  Future<String> addShop(
      {required String ownerID,
      required String shopName,
      required String shopDescription,
      required String? shopProfileImage,
      required String? shopCoverImage,
      required String shopCategory,
      required String location,
      required String timeOfWorking,
      required List<String> socialUrl}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "ownerID": ownerID,
      "shopName": shopName,
      "shopDescription": shopDescription,
      "shopProfileImage": shopProfileImage ?? "noImage",
      "shopCoverImage": shopCoverImage ?? "noImage",
      "shopCategory": shopCategory,
      "location": location,
      "timeOfWorking": timeOfWorking,
      "socialUrl": socialUrl,
      "rate": 0,
      "isFavorit": false,
      "isFollow": false
    };
    try {
      response = await http.post(Uri.parse(ENDPOINT + "/shops/addShop"),
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
          .delete(Uri.parse(ENDPOINT + "/shops/delete/$shopID"), headers: {
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

  Future<String> updateShop(
      {required String shopID,
      required String shopName,
      required String shopDescription,
      required String? shopProfileImage,
      required String? shopCoverImage,
      required String shopCategory,
      required String location,
      required String timeOfWorking,
      required List<String> socialUrl}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "shopName": shopName,
      "shopDescription": shopDescription,
      "shopProfileImage": shopProfileImage ?? "noImage",
      "shopCoverImage": shopCoverImage ?? "noImage",
      "shopCategory": shopCategory,
      "location": location,
      "timeOfWorking": timeOfWorking,
      "socialUrl": socialUrl,
    };
    try {
      response = await http.put(
          Uri.parse(ENDPOINT + "/shops/updateShop/$shopID"),
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
          .get(Uri.parse(ENDPOINT + "/shops/locations/$location"), headers: {
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
