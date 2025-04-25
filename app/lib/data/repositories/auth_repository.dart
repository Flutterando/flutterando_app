import 'package:result_dart/result_dart.dart';

import '../../core/exceptions/exceptions.dart';
import '../../core/extensions/validator_extension.dart';
import '../../domain/dto/credentials_login_dto.dart';
import '../../domain/dto/recover_password_dto.dart';
import '../../domain/dto/recover_password_otp_dto.dart';
import '../../domain/dto/recover_password_send_email_dto.dart';
import '../../domain/dto/register_dto.dart';
import '../../domain/dto/register_otp_dto.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/validators/credentials_login_validator.dart';
import '../../domain/validators/recover_password_otp_validator.dart';
import '../../domain/validators/recover_password_send_email_validation.dart';
import '../../domain/validators/recover_password_validation.dart';
import '../../domain/validators/register_validation.dart';
import '../adapters/session_adapter.dart';
import '../adapters/user_adapter.dart';
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
        .flatMap((_) => authApi.getLoggedUser())
        .map(_toLoggedUserEntity)
        .flatMap(storage.saveUser);
  }

  AsyncResult<Unit> register(RegisterDto dto) async {
    final validator = RegisterValidation();

    return validator
        .validateResult(dto) //
        .flatMap(authApi.register)
        .pure(dto)
        .mapError((e) => e as LoginException)
        .pure(unit);
  }

  AsyncResult<LoggedUser> getLoggedUser() async => storage.getUser();

  AsyncResult<Unit> logout() => storage.clear();

  AsyncResult<String> getRefreshToken() async {
    return storage
        .getRefreshToken()
        .flatMap(authApi.getRefreshToken)
        .map(_toSessionEntity)
        .flatMap(storage.saveSession)
        .map((session) => session.token);
  }

  AsyncResult<Unit> confirmOtpRegisterCode(RegisterOtpDto dto) {
    return authApi.confirmOtpRegisterCode(dto).pure(unit);
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

  AsyncResult<Unit> confirmOtpPassword(RecoverPasswordOtpDto dto) async {
    final validator = RecoverPasswordOtpValidator();

    return validator
        .validateResult(dto)
        .flatMap(authApi.confirmOtpPassword)
        .map(_toSessionEntity)
        .flatMap(storage.saveSession)
        .pure(unit);
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

  LoggedUser _toLoggedUserEntity(RestClientResponse response) =>
      LoggedUserAdapter.fromJson(response.data);

  CredentialsLoginDto _toCredentialsLoginDto(RegisterDto dto) =>
      CredentialsLoginDto(email: dto.email, password: dto.password);
}
