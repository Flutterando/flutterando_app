import 'package:vaden/vaden.dart';

@DTO()
class UpdateUserDto with Validator<UpdateUserDto> {
  final String? name;
  final String? email;
  final String? password;

  UpdateUserDto({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  LucidValidator<UpdateUserDto> validate(
      ValidatorBuilder<UpdateUserDto> builder) {
    builder //
        .ruleFor((p) => p.name, key: 'name');

    builder //
        .ruleFor((p) => p.email, key: 'email')
        .validEmail();

    builder //
        .ruleFor((p) => p.password, key: 'password');

    return builder;
  }
}
