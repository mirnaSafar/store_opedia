// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shopesapp/data/models/shop.dart';

class User {
  String id;
  String userName;
  String phoneNumber;
  String email;
  String password;
  List<Shop>? followedStores;

  User({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    this.followedStores,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      //   'token': token,
      'phoneNumber': phoneNumber,
      'password': password
    };
  }

  factory User.from(User oldUserObj) {
    return User(
        id: oldUserObj.id,
        email: oldUserObj.email,
        //   token: oldUserObj.token,
        phoneNumber: oldUserObj.phoneNumber,
        userName: oldUserObj.userName,
        password: oldUserObj.password);
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as String,
        email: map['email'] as String,
        // token: map['token'] as String,
        phoneNumber: map['phoneNumber'] as String,
        userName: map["userName"] as String,
        password: map['password']);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  //@override
  //String toString() => 'User(id: $id, email: $email, token: $token)';
}
