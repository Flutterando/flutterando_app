import 'package:backend/src/domain/dto/user/user_dto.dart';
import 'package:vaden/vaden.dart';

@DTO()
class UserCreateDto extends UserDTO with Validator<UserCreateDto> {
  UserCreateDto({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.password,
  });

  @override
  LucidValidator<UserCreateDto> validate(
      ValidatorBuilder<UserCreateDto> builder) {
    builder //
        .ruleFor((p) => p.firstName, key: 'firstName')
        .notEmptyOrNull();

    builder //
        .ruleFor((p) => p.lastName, key: 'lastName')
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
