import 'package:vaden/vaden.dart';

@DTO()
class EmailOtpVerificationDTO with Validator<EmailOtpVerificationDTO> {
  final String email;
  final String code;

  EmailOtpVerificationDTO({required this.email, required this.code});

  @override
  LucidValidator<EmailOtpVerificationDTO> validate(
      ValidatorBuilder<EmailOtpVerificationDTO> builder) {
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
