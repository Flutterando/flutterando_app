import 'user_entity.dart';

class Post {
  final int id;
  final String description;
  final String link;
  final String image;
  final String imageSubtitle;
  final User author;

  Post({
    required this.id,
    required this.description,
    required this.link,
    required this.image,
    required this.imageSubtitle,
    required this.author,
  });
}
