import 'dart:convert';

class User {
  String id;
  String userName;
  String phoneNumber;
  String email;
  String password;

  User({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.id,
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
