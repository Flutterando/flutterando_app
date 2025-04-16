import 'dart:math';

import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../domain/services/password_code_generator_service.dart';

@Service()
class PasswordCodeGeneratorServiceImpl implements PasswordCodeGeneratorService {
  @override
  Result<String> codeGenerator([int? scale]) {
    final int digits = scale ?? 6;
    if (digits <= 0) {
      return Failure(Exception('Scale must be greater than 0'));
    }

    final random = Random();

    int min = pow(10, digits - 1).toInt();
    int max = pow(10, digits).toInt() - 1;

    return Success('${min + random.nextInt(max - min)}');
  }
}
