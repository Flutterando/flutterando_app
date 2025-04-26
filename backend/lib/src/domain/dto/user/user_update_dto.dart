import 'package:backend/src/domain/dto/user/user_dto.dart';
import 'package:vaden/vaden.dart';

@DTO()
class UserUpdateDTO extends UserDTO with Validator<UserUpdateDTO> {
  UserUpdateDTO({
    super.firstName,
    super.lastName,
    super.email,
    super.password,
  });

  @override
  LucidValidator<UserUpdateDTO> validate(
      ValidatorBuilder<UserUpdateDTO> builder) {
    builder //
        .ruleFor((p) => p.firstName, key: 'firstName');

    builder //
        .ruleFor((p) => p.lastName, key: 'lastName');

    builder //
        .ruleFor((p) => p.email, key: 'email');

    builder //
        .ruleFor((p) => p.password, key: 'password');

    return builder;
  }
}
