import 'package:vaden/vaden.dart';

@DTO()
class PostsCreateDTO {
  final String title;
  final String? subtitle;
  final String? description;
  final String? link;
  final String? image;

  SignedPostsCreateDTO signed(int author) {
    return SignedPostsCreateDTO(
      author: author,
      title: title,
      subtitle: subtitle,
      description: description,
      link: link,
      image: image,
    );
  }

  PostsCreateDTO({
    required this.title,
    this.subtitle,
    this.description,
    this.link,
    this.image,
  });
}

class SignedPostsCreateDTO extends PostsCreateDTO {
  final int author;
  SignedPostsCreateDTO({
    required this.author,
    required super.title,
    super.subtitle,
    super.description,
    super.link,
    super.image,
  });

  Map<String, dynamic> toMapQuery() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'link': link,
      'image': image,
      'users': author,
    };
  }
}
