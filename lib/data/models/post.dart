class Post {
  String shopeID;
  String id;
  String title;
  String description;
  String postImages;
  String category;
  Map<String, dynamic> owner;
  String productPrice;
  int? rate;
  bool? isFavorit;

  Post(
      {required this.title,
      required this.description,
      required this.category,
      required this.owner,
      required this.productPrice,
      required this.postImages,
      required this.shopeID,
      this.isFavorit = false,
      required this.rate,
      required this.id});
}
