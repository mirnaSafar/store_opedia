import 'dart:convert';

import 'package:shopesapp/data/models/shop.dart';

class Owner {
  String id;
  String name;
  String email;
  String password;
  String phoneNumber;
  Shop currentShop;
  Owner(
      {required this.name,
      required this.password,
      required this.email,
      required this.phoneNumber,
      required this.id,
      required this.currentShop});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'currentShope': currentShop,
      'name': name,
    };
  }

  factory Owner.from(Owner oldOnwerObject) {
    return Owner(
        id: oldOnwerObject.id,
        name: oldOnwerObject.name,
        email: oldOnwerObject.email,
        phoneNumber: oldOnwerObject.phoneNumber,
        currentShop: oldOnwerObject.currentShop,
        password: oldOnwerObject.password);
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
        id: map['id'] as String,
        email: map['email'] as String,
        currentShop: map['currentShope'] as Shop,
        phoneNumber: map['phoneNumber'] as String,
        name: map["name"] as String,
        password: map['password'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Owner.fromJson(String source) =>
      Owner.fromMap(json.decode(source) as Map<String, dynamic>);
}
