import 'package:result_dart/result_dart.dart';

import '../../core/extensions/validator_extension.dart';
import '../../domain/dto/credentials_login_dto.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/validators/credentials_login_validator.dart';
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
        .map(_toSession)
        .flatMap(storage.saveSession)
        .map((session) => session.user);
  }

  Session _toSession(RestClientResponse response) {
    final loggedUser = LoggedUserAdapter.fromJson(response.data['user']);

    return Session(
      user: loggedUser,
      token: response.data['token'],
      refreshToken: response.data['refreshToken'],
    );
  }
}
