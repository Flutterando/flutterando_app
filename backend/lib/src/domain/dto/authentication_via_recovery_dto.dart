import 'package:vaden/vaden.dart';

@DTO()
class AuthenticationViaRecoveryDTO
    with Validator<AuthenticationViaRecoveryDTO> {
  final String email;
  final String code;

  AuthenticationViaRecoveryDTO({required this.email, required this.code});

  @override
  LucidValidator<AuthenticationViaRecoveryDTO> validate(
      ValidatorBuilder<AuthenticationViaRecoveryDTO> builder) {
    builder //
        .ruleFor((p) => p.email, key: 'email')
        .notEmpty()
        .validEmail();

    builder //
        .ruleFor((p) => p.code, key: 'code')
        .notEmpty()
        .matchesPattern(r"^\d{4}$", message: "Invalid code");

    return builder;
  }
}
