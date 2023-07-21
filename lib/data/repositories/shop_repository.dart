import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopesapp/constant/endpoint.dart';

class ShopRepository {
  Future<String?> sendShopRating(
      String ownerId, String shopId, double rate) async {
    http.Response response;

    try {
      response = await http.post(Uri.http(ENDPOINT, "/$ownerId/$shopId"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'shopRate': rate}));
    } catch (e) {
      return null;
    }
    if (response.statusCode == 200) {
      return 'Success';
    }

    return null;
  }

  Future<Map<String, dynamic>?> getOwnerShpos(
      {required String? ownerID, required String message}) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    Map<String, dynamic> requestBody = {
      "id": ownerID,
      "message": message,
    };

    try {
      response = await http.post(
          Uri.http(ENDPOINT, "/store/activation/$ownerID"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      return null;
    }
    if (response.statusCode == 200) {
      parsedResult = jsonDecode(response.body);
      //  print(parsedResult);
      return parsedResult;
    }

    return null;
  }

  Future<Map<String, dynamic>?> getShops({required String? ownerID}) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    Map<String, dynamic> requestBody = {
      "ownerID": ownerID,
    };
    try {
      response = await http.post(Uri.http(ENDPOINT, "/show/stores/$ownerID"),
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
  /* Map<String, dynamic>? getOwnerShposTest() {
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
          "socialUrl": ['insta', 'face'],
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
          "socialUrl": ['insta', 'face'],
          "rate": 4,
          "followesNumber": 100,
        },
      ]
    };
  }*/

  Future<String> addShop({
    required String? facebookAccount,
    required String? instagramAccount,
    required String ownerID,
    required String shopName,
    required String shopDescription,
    required String? shopProfileImage,
    required String? shopCoverImage,
    required String shopCategory,
    required String location,
    required String closing,
    required String opening,
    required String shopPhoneNumber,
  }) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "id": ownerID,
      "name": shopName,
      "description": shopDescription,
      "profile_photo": shopProfileImage ?? "noImage",
      "cover_photo": shopCoverImage ?? "noImage",
      "category": shopCategory,
      "address": location,
      "facebook": facebookAccount,
      "insta": instagramAccount,
      "opening": opening,
      "closing": closing,
      "rate": 0,
      "phone": shopPhoneNumber,
    };
    try {
      response = await http.post(Uri.http(ENDPOINT, "/AddStore/$ownerID"),
          body: jsonEncode(requestBody),
          headers: {
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

  Future<String> deleteShop(
      {required String shopID, required String ownerID}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "id": ownerID,
      "shopID": shopID,
    };

    try {
      response = await http.delete(Uri.http(ENDPOINT, "/delete/store/$ownerID"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      return "Failed";
    }
    if (response.statusCode == 200) {
      return "Success";
    }
    return "Failed";
  }

  Future<String> editShop({
    required String ownerID,
    required String shopID,
    required String shopName,
    required String shopDescription,
    required String? shopProfileImage,
    required String? shopCoverImage,
    required String shopCategory,
    required String location,
    required String endWorkTime,
    required String startWorkTime,
    String? insta,
    String? facebook,
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
      "insta": insta ?? "insta",
      "facebook": facebook ?? "facebook",
      "shopPhoneNumber": shopPhoneNumber,
      "id": ownerID,
      "shopID": shopID,
    };
    try {
      response = await http.put(Uri.http(ENDPOINT, "/profile/store/$ownerID"),
          body: jsonEncode(requestBody),
          headers: {
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
    if (response.statusCode == 200) {
      parsedResult = jsonDecode(response.body);
      return parsedResult;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getAllStores({required String id}) async {
    http.Response response;
    Map<String, dynamic> parsedResult;
    Map<String, dynamic> requestBody = {"id": id};

    try {
      response = await http.post(Uri.http(ENDPOINT, "/show/stores/$id"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
      //   print(response.statusCode);
    } catch (e) {
      return null;
    }
    if (response.statusCode == 200) {
      parsedResult = jsonDecode(response.body);
      //  print(parsedResult);
      return parsedResult;
    }
    return null;
  }

  Future<String?> toggleActivation(
      {required String shopID, required String ownerID}) async {
    http.Response response;
    Map<String, dynamic> requestBody = {
      "id": ownerID,
      "shopId": shopID,
    };

    try {
      response = await http.post(
          Uri.http(ENDPOINT, "/store/toggleActivation/$shopID"),
          body: jsonEncode(requestBody),
          headers: {
            'Content-Type': 'application/json',
          });
      //   print(response.statusCode);
    } catch (e) {
      return "Faild";
    }
    if (response.statusCode == 200) {
      //  print(parsedResult);
      return "Success";
    }
    return "Faild";
  }
}
