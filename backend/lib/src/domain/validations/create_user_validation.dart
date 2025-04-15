import 'package:backend/src/domain/dto/user_dto.dart';
import 'package:vaden/vaden.dart';

@Component()
class CreateUserValidator implements Validator<UserDTO> {
  @override
  LucidValidator<UserDTO> validate(ValidatorBuilder<UserDTO> builder) {
    builder //
        .ruleFor((p) => p.firstName, key: 'name')
        .notEmptyOrNull();

    builder //
        .ruleFor((p) => p.lastName, key: 'name')
        .notEmptyOrNull();

    builder //
        .ruleFor((p) => p.email, key: 'email')
        .notEmptyOrNull()
        .validEmail();

    builder //
        .ruleFor((p) => p.password, key: 'password')
        .notEmptyOrNull();

    return builder;
  }
}
