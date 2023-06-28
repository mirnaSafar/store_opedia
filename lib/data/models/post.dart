class Post {
  String shopeID;
  String postID;
  String title;
  String description;
  String postImage;
  String category;
  String ownerID;
  String ownerName;
  String ownerPhoneNumber;
  String price;
  int? rate;
  bool? isFavorit;

  Post(
      {required this.title,
      required this.description,
      required this.category,
      required this.ownerID,
      required this.ownerName,
      required this.ownerPhoneNumber,
      required this.price,
      required this.postImage,
      required this.shopeID,
      this.isFavorit = false,
      this.rate = 0,
      required this.postID});
}
