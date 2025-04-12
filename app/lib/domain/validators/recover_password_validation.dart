import 'package:lucid_validation/lucid_validation.dart';

import '../dto/recover_password_dto.dart';

class RecoverPasswordValidation extends LucidValidator<RecoverPasswordDto> {
  RecoverPasswordValidation() {
    ruleFor((dto) => dto.password, key: 'password', label: 'Senha') //
        .notEmpty()
        .minLength(8)
        .mustHaveUppercase()
        .mustHaveLowercase()
        .mustHaveNumber()
        .mustHaveSpecialCharacter();

    ruleFor(
      (dto) => dto.confirmPassword,
      key: 'confirmPassword',
      label: 'Confirmar senha',
    ) //
    .equalTo((dto) => dto.password, message: 'As senhas devem ser iguais');
  }
}
