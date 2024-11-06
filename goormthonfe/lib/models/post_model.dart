// post_model.dart

class Post {
  String title;
  String content;
  String location;
  String date;
  String distance;
  String pace;
  int interest;
  int views;
  bool isLiked;

  Post({
    required this.title,
    required this.content,
    required this.location,
    required this.date,
    required this.distance,
    required this.pace,
    this.interest = 6,
    this.views = 60,
    this.isLiked = false,
  });
}
