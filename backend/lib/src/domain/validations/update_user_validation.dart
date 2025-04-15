import 'package:backend/src/domain/dto/user_dto.dart';
import 'package:vaden/vaden.dart';

@Component()
class UpdateUserValidation implements Validator<UserDTO> {
  @override
  LucidValidator<UserDTO> validate(ValidatorBuilder<UserDTO> builder) {
    builder //
        .ruleFor((p) => p.firstName, key: 'name');

    builder //
        .ruleFor((p) => p.lastName, key: 'name');

    builder //
        .ruleFor((p) => p.email, key: 'email');

    builder //
        .ruleFor((p) => p.password, key: 'password');

    return builder;
  }
}
