import 'package:vaden/vaden.dart';

import '../dto/posts_create_dto.dart';

@Component()
class CreatePostsValidation implements Validator<PostsCreateDTO> {
  @override
  LucidValidator<PostsCreateDTO> validate(
      ValidatorBuilder<PostsCreateDTO> builder) {
    builder //
        .ruleFor((p) => p.title, key: 'title')
        .notEmptyOrNull();

    builder //
        .ruleFor((p) => p.subtitle, key: 'subtitle');

    builder //
        .ruleFor((p) => p.description, key: 'description');

    builder //
        .ruleFor((p) => p.link, key: 'link');

    builder //
        .ruleFor((p) => p.image, key: 'image');

    return builder;
  }
}
