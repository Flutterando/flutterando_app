import 'package:vaden/vaden.dart';

@DTO()
class PostsCreateDTO with Validator<PostsCreateDTO> {
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

  @override
  LucidValidator<PostsCreateDTO> validate(
      ValidatorBuilder<PostsCreateDTO> builder) {
    builder //
        .ruleFor((p) => p.description, key: 'description')
        .notEmptyOrNull();
    ;

    builder //
        .ruleFor((p) => p.link, key: 'link');

    builder //
        .ruleFor((p) => p.image, key: 'image');

    builder //
        .ruleFor((p) => p.imageSubtitle, key: 'imageSubtitle');

    return builder;
  }
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
