class Post {
  String id;
  String title;
  String description;
  List<String> postImages;
  String category;
  Map<String, dynamic> owner;
  String productPrice;
  String rate;
  bool? isFavorit;

  Post(
      {required this.title,
      required this.description,
      required this.category,
      required this.owner,
      required this.productPrice,
      required this.postImages,
      this.isFavorit = false,
      required this.rate,
      required this.id});
}
