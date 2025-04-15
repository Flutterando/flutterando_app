import 'package:vaden/vaden.dart';

import '../dto/posts_update_dto.dart';

@Component()
class UpdatePostsValidation implements Validator<UpdatePostsDTO> {
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
