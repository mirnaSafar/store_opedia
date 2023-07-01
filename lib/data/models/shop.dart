import 'dart:convert';

class Shop {
  String ownerName;
  String ownerID;
  String ownerPhoneNumber;
  String ownerEmail;
  String shopName;
  String? shopPhoneNumber;
  String? shopProfileImage;
  String? shopCoverImage;
  String? shopDescription;
  String shopCategory;
  String location;
  String startWorkTime;
  String endWorkTime;
  int? followesNumber;
  String? socialUrl;
  int? rate;
  String shopID;
  bool? isFollow;
  bool? isFavorit;

  Shop({
    required this.shopCategory,
    required this.location,
    required this.startWorkTime,
    required this.endWorkTime,
    required this.ownerID,
    required this.ownerEmail,
    required this.ownerPhoneNumber,
    required this.shopID,
    required this.shopName,
    required this.ownerName,
    this.shopPhoneNumber,
    this.shopProfileImage,
    this.shopCoverImage,
    this.shopDescription,
    this.socialUrl,
    this.rate = 0,
    this.isFollow = false,
    this.isFavorit = false,
    this.followesNumber = 0,
    //  this.numberOfFollowers = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "shopCategory": shopCategory,
      "shopName": shopName,
      "shopID": shopID,
      "shopPhoneNumber": shopPhoneNumber,
      "shopProfileImage": shopProfileImage,
      "shopCoverImage": shopCoverImage,
      "shopDescription": shopDescription,
      "location": location,
      "startWorkTime": startWorkTime,
      "endWorkTime": endWorkTime,
      "socialUrl": socialUrl,
      "rate": rate,
      "ownerName": ownerName,
      "ownerID": ownerID,
      "ownerEmail": ownerEmail,
      "ownerPhoneNumber": ownerPhoneNumber,
      "followesNumber": followesNumber
    };
  }

  factory Shop.fromMap(var map) {
    return Shop(
      shopName: map["shopName"] as String,
      shopProfileImage: map["shopProfileImage"] as String?,
      shopCategory: map["shopCategory"],
      shopCoverImage: map["shopCoverImage"] as String?,
      shopDescription: map["shopDescription"] as String?,
      location: map["location"] as String,
      startWorkTime: map["startWorkTime"] as String,
      endWorkTime: map["endWorkTime"] as String,
      shopID: map["shopID"] as String,
      socialUrl: map["socialUrl"] as String?,
      rate: map["rate"] as int?,
      shopPhoneNumber: map["shopPhoneNumber"] as String?,
      ownerID: map["ownerID"] as String,
      ownerEmail: map["ownerEmail"] as String,
      ownerPhoneNumber: map["ownerPhoneNumber"] as String,
      ownerName: map["ownerName"] as String,
      followesNumber: map["followesNumber"] as int?,
    );
  }

  factory Shop.from(Shop oldShop) {
    return Shop(
      shopCategory: oldShop.shopCategory,
      location: oldShop.location,
      startWorkTime: oldShop.startWorkTime,
      endWorkTime: oldShop.endWorkTime,
      ownerID: oldShop.ownerID,
      ownerEmail: oldShop.ownerEmail,
      ownerPhoneNumber: oldShop.ownerPhoneNumber,
      shopID: oldShop.shopID,
      shopName: oldShop.shopName,
      ownerName: oldShop.ownerName,
      shopCoverImage: oldShop.shopCoverImage,
      shopDescription: oldShop.shopDescription,
      shopPhoneNumber: oldShop.ownerPhoneNumber,
      shopProfileImage: oldShop.shopProfileImage,
      socialUrl: oldShop.socialUrl,
    );
  }
  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) =>
      Shop.fromMap(json.decode(source) as Map<String, dynamic>);
}
