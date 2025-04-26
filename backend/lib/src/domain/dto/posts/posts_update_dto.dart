import 'package:vaden/vaden.dart';

@DTO()
class UpdatePostsDTO with Validator<UpdatePostsDTO> {
  final int id;
  final String? description;
  final String? link;
  final String? image;
  final String? imageSubtitle;
  UpdatePostsDTO({
    required this.id,
    this.description,
    this.link,
    this.image,
    this.imageSubtitle,
  });

  Map<String, dynamic> toMapQuery() {
    return {
      'id': id,
      'description': description,
      'link': link,
      'image': image,
      'image_subtitle': imageSubtitle
    };
  }

  @override
  LucidValidator<UpdatePostsDTO> validate(
      ValidatorBuilder<UpdatePostsDTO> builder) {
    builder //
        .ruleFor((p) => p.id, key: 'id')
        .isNotNull();

    builder //
        .ruleFor((p) => p.description, key: 'description');

    builder //
        .ruleFor((p) => p.link, key: 'link');

    builder //
        .ruleFor((p) => p.image, key: 'image');

    builder //
        .ruleFor((p) => p.imageSubtitle, key: 'imageSubtitle');

    return builder;
  }
}
