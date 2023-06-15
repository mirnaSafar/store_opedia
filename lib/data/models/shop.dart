import 'dart:convert';

class Shop {
  Map<String, dynamic> owner;
  String shopName;
  String shopProfileImage;
  String shopCoverImage;
  String shopDescription;
  String shopCategory;
  String location;
  String timeOfWorking;
  List<String> socialUrl;
  int? rate;
  String shopID;
  bool? isFollow;
  bool? isFavorit;

  Shop(
      {required this.shopName,
      required this.shopProfileImage,
      required this.shopCoverImage,
      required this.shopDescription,
      required this.shopCategory,
      required this.location,
      required this.timeOfWorking,
      required this.socialUrl,
      required this.rate,
      this.isFollow = false,
      this.isFavorit = false,
      required this.owner,
      required this.shopID});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "shopName": shopName,
      "shopID": shopID,
      "shopProfileImage": shopProfileImage,
      "shopCoverImage": shopCoverImage,
      "shopDescription": shopDescription,
      "location": location,
      "timeOfWorking": timeOfWorking,
      "socialUrl": socialUrl,
      "rate": rate,
      "owner": owner
    };
  }

  factory Shop.fromMap(var map) {
    return Shop(
        shopName: map["shopName"] as String,
        shopProfileImage: map["  shopProfileImage"] as String,
        shopCategory: map["shopCategory"] as String,
        shopCoverImage: map["shopCoverImage"] as String,
        shopDescription: map["shopDescription"] as String,
        location: map["location"] as String,
        timeOfWorking: map["timeOfWorking"] as String,
        shopID: map["shopID"] as String,
        socialUrl: map["socialUrl"] as List<String>,
        rate: map["rate"] as int,
        owner: map["owner"] as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) =>
      Shop.fromMap(json.decode(source) as Map<String, dynamic>);
}
