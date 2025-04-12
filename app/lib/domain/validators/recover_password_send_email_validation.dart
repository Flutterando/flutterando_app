import 'package:lucid_validation/lucid_validation.dart';

import '../dto/recover_password_send_email_dto.dart';

class RecoverPasswordSendEmailValidation
    extends LucidValidator<RecoverPasswordSendEmailDto> {
  RecoverPasswordSendEmailValidation() {
    ruleFor((dto) => dto.email, key: 'email', label: 'E-mail') //
    .validEmail();
  }
}
