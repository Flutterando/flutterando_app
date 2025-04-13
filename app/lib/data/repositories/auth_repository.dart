import 'package:result_dart/result_dart.dart';

import '../../core/exceptions/exceptions.dart';
import '../../core/extensions/validator_extension.dart';
import '../../domain/dto/credentials_login_dto.dart';
import '../../domain/dto/recover_password_dto.dart';
import '../../domain/dto/recover_password_send_email_dto.dart';
import '../../domain/dto/register_dto.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/validators/credentials_login_validator.dart';
import '../../domain/validators/recover_password_send_email_validation.dart';
import '../../domain/validators/recover_password_validation.dart';
import '../../domain/validators/register_validation.dart';
import '../adapters/session_adapter.dart';
import '../services/api/auth_api.dart';
import '../services/api/client_http/rest_client_response.dart';
import '../services/storage/auth_storage.dart';

class AuthRepository {
  final AuthApi authApi;
  final AuthStorage storage;

  AuthRepository(this.authApi, this.storage);

  AsyncResult<LoggedUser> login(CredentialsLoginDto credentials) async {
    final validator = CredentialsLoginValidator();

    return validator
        .validateResult(credentials) //
        .flatMap(authApi.login)
        .map(_toSessionEntity)
        .flatMap(storage.saveSession)
        .map((session) => session.user);
  }

  AsyncResult<Unit> register(RegisterDto dto) async {
    final validator = RegisterValidation();

    return validator
        .validateResult(dto) //
        .flatMap(authApi.register)
        .pure(dto)
        .map(_toCredentialsLoginDto)
        .flatMap(authApi.login)
        .mapError((e) => e as LoginException)
        .pure(unit);
  }

  AsyncResult<Unit> requestToRecoverPassword(
    RecoverPasswordSendEmailDto dto,
  ) async {
    final validator = RecoverPasswordSendEmailValidation();

    return validator
        .validateResult(dto)
        .flatMap(authApi.requestToRecoverPassword)
        .pure(unit);
  }

  AsyncResult<Unit> confirmOtpPassword(String code) async {
    if (code.isEmpty) return Failure(Exception('invalid code'));

    return authApi.confirmOtpPassword(code).pure(unit);
  }

  AsyncResult<Unit> newPassword(RecoverPasswordDto dto) async {
    final validator = RecoverPasswordValidation();

    return validator
        .validateResult(dto)
        .flatMap(authApi.newPassword)
        .pure(unit);
  }

  Session _toSessionEntity(RestClientResponse response) =>
      SessionAdapter.fromJson(response.data);

  CredentialsLoginDto _toCredentialsLoginDto(RegisterDto dto) =>
      CredentialsLoginDto(email: dto.email, password: dto.password);
}
