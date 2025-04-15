import 'package:lucid_validation/lucid_validation.dart';
import 'package:result_dart/result_dart.dart';

extension ValidatorExtension<T extends Object> on LucidValidator<T> {
  AsyncResult<T> validateResult(T value) async {
    final result = validate(value);

    if (result.isValid) {
      return Success(value);
    }

    final exception = result.exceptions.first;
    return Failure(Exception(exception.message));
  }
}

extension UrlValidValidator on SimpleValidationBuilder<String?> {
  SimpleValidationBuilder<String?> validUrl({String label = 'URL'}) {
    return use((value, entity) {
      final regex = RegExp(
        r'^(https?:\/\/|ftp:\/\/)?(www\.)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/[^\s]*)?$',
        caseSensitive: false,
      );
      if (value == null || value.isEmpty) {
        return null;
      }
      if (regex.hasMatch(value)) {
        return null;
      }

      const currentCode = 'invalid_url';
      final currentMessage = LucidValidation.global.languageManager.translate(
        currentCode,
        parameters: {'PropertyName': label.isNotEmpty ? label : 'invalid_url'},
      );

      return ValidationException(
        message: currentMessage,
        code: currentCode,
        key: key,
        entity: '',
      );
    });
  }
}
