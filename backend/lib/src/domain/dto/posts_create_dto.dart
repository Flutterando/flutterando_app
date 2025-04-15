import 'package:vaden/vaden.dart';

@DTO()
class PostsCreateDTO {
  final String description;
  final String? link;
  final String? image;
  final String? imageSubtitle;
  SignedPostsCreateDTO signed(int author) {
    return SignedPostsCreateDTO(
      author: author,
      description: description,
      link: link,
      image: image,
      imageSubtitle: imageSubtitle,
    );
  }

  PostsCreateDTO({
    required this.description,
    this.link,
    this.image,
    this.imageSubtitle,
  });
}

class SignedPostsCreateDTO extends PostsCreateDTO {
  final int author;
  SignedPostsCreateDTO({
    required this.author,
    required super.description,
    super.link,
    super.image,
    super.imageSubtitle,
  });

  Map<String, dynamic> toMapQuery() {
    return {
      'description': description,
      'link': link,
      'image': image,
      'image_subtitle': imageSubtitle,
      'users': author,
    };
  }
}
