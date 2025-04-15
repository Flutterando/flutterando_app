import 'package:lucid_validation/lucid_validation.dart';

import '../dto/post_dto.dart';
import '../../core/extensions/validator_extension.dart';

class PostValidator extends LucidValidator<PostDto> {
  PostValidator() {
    ruleFor((c) => c.description, key: 'description', label: 'Descricao') //
        .notEmpty() //
        .maxLength(1000);

    ruleFor((c) => c.image, key: 'image', label: 'Imagem') //
        .when((c) => c.image != null) //
        .notEmpty() //
        .validUrl();

    ruleFor((c) => c.link, key: 'link', label: 'Link') //
        .when((c) => c.link != null) //
        .validUrl();

    ruleFor((c) => c.imageSubtitle, key: 'subtitle', label: 'SubTitulo') //
        .when((c) => c.imageSubtitle != null) //
        .notEmpty() //
        .maxLength(100);
  }
}
