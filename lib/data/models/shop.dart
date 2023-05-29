import 'package:shopesapp/data/models/post.dart';

class Shop {
  String shopName;
  String shopProfileImage;
  String shopCoverImage;
  String shopDescription;
  String shopCategory;
  String location;
  String timeOfWorking;
  List<String> socialUrl;
  List<Post> shopPosts;
  String rate;
  String id;

  Shop(
      {required this.shopName,
      required this.shopProfileImage,
      required this.shopCoverImage,
      required this.shopDescription,
      required this.shopCategory,
      required this.location,
      required this.timeOfWorking,
      required this.socialUrl,
      required this.shopPosts,
      required this.rate,
      required this.id});
}
