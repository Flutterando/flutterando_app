import 'package:lucid_validation/lucid_validation.dart';

import '../dto/credentials_login_dto.dart';

class CredentialsLoginValidator extends LucidValidator<CredentialsLoginDto> {
  CredentialsLoginValidator() {
    ruleFor((c) => c.email, key: 'email', label: 'E-mail') //
    .notEmpty().validEmail();

    ruleFor((c) => c.password, key: 'password', label: 'Senha') //
        .notEmpty()
        .minLength(5);
  }
}