import 'package:vaden/vaden.dart';

import '../dto/posts_create_dto.dart';

@Component()
class CreatePostsValidation implements Validator<PostsCreateDTO> {
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
