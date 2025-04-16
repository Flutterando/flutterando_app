import 'package:lucid_validation/lucid_validation.dart';

import '../dto/recover_password_otp_dto.dart';

class RecoverPasswordOtpValidator
    extends LucidValidator<RecoverPasswordOtpDto> {
  RecoverPasswordOtpValidator() {
    ruleFor((dto) => dto.email, key: 'email', label: 'E-mail') //
    .validEmail();

    ruleFor((dto) => dto.code, key: 'code', label: 'Code') //
    .notEmpty();
  }
}
