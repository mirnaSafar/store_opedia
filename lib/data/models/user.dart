import 'dart:convert';

class User {
  String id;
  String name;
  String phoneNumber;
  String email;
  String password;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password
    };
  }

  factory User.from(User oldUserObj) {
    return User(
        id: oldUserObj.id,
        email: oldUserObj.email,
        phoneNumber: oldUserObj.phoneNumber,
        name: oldUserObj.name,
        password: oldUserObj.password);
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as String,
        email: map['email'] as String,
        phoneNumber: map['phoneNumber'] as String,
        name: map["userName"] as String,
        password: map['password'] as String);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
