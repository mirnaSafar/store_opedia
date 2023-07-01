import 'dart:convert';

class Owner {
  String id;
  String name;
  String email;
  String password;
  String phoneNumber;
  // Shop? currentShop;
  Owner({
    required this.name,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.id,
  });

  Map<String, dynamic> toMap(Owner owner) {
    return <String, dynamic>{
      'id': owner.id,
      'email': owner.email,
      'phoneNumber': owner.phoneNumber,
      'password': owner.password,
      'name': owner.name,
    };
  }

  factory Owner.from(Owner oldOnwerObject) {
    return Owner(
        id: oldOnwerObject.id,
        name: oldOnwerObject.name,
        email: oldOnwerObject.email,
        phoneNumber: oldOnwerObject.phoneNumber,
        //    currentShop: oldOnwerObject.currentShop,
        password: oldOnwerObject.password);
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
        id: map['ownerID'] as String,
        email: map['email'] as String,
        //  currentShop: map['currentShope'] as Shop,
        phoneNumber: map['ownerPhoneNumber'] as String,
        name: map["ownerName"] as String,
        password: map['password'] as String);
  }

  // String toJson() => json.encode(toMap());

  factory Owner.fromJson(String source) =>
      Owner.fromMap(json.decode(source) as Map<String, dynamic>);
}
