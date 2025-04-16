import 'package:result_dart/result_dart.dart';

abstract interface class PasswordCodeGeneratorService {
  Result<String> codeGenerator([int? scale]);
}
