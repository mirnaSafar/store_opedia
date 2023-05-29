import 'package:shopesapp/data/models/shop.dart';

class Owner {
  String id;
  String name;
  String email;
  String phoneNumber;
  List<Shop> shopes;
  Owner({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.shopes,
    required this.id,
  });
}
