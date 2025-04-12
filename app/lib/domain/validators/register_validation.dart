import 'package:lucid_validation/lucid_validation.dart';

import '../dto/register_dto.dart';

class RegisterValidation extends LucidValidator<RegisterDto> {
  RegisterValidation() {
    ruleFor((dto) => dto.firstName, key: 'firstName', label: 'Nome') //
    .notEmpty();

    ruleFor((dto) => dto.lastName, key: 'lastName', label: 'Sobrenome') //
    .notEmpty();

    ruleFor((dto) => dto.email, key: 'email', label: 'E-mail') //
    .validEmail();

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
    .equalTo((dto) => dto.password);
  }
}
