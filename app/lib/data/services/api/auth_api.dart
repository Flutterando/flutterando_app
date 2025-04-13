import 'package:result_dart/result_dart.dart';
import '../../../core/logger/logger_mixin.dart';
import '../../../domain/dto/credentials_login_dto.dart';
import '../../../domain/dto/register_dto.dart';
import 'client_http/i_rest_client.dart';
import 'client_http/rest_client_request.dart';
import 'client_http/rest_client_response.dart';
import 'mock_payload/mock_payload.dart';

class AuthApi with LoggerMixin {
  final IRestClient client;

  AuthApi(this.client);

  AsyncResult<RestClientResponse> login(CredentialsLoginDto credentials) async {
    final logger = log.forMethod()..logInfo(data: credentials);

    // TODO Original Code
    // return await client
    //     .post(
    //       RestClientRequest(path: '/auth/login', data: credentials.toJson()),
    //     )
    //     .onSuccess(logger.fromSuccess)
    //     .onFailure(logger.fromException);

    // Mock Code
    return Success(
      RestClientResponse(
        request: RestClientRequest(
          path: '/auth/login',
          data: credentials.toJson(),
        ),
        data: mockPayloadLogin,
        statusCode: 200,
      ),
    );
  }

  AsyncResult<RestClientResponse> register(RegisterDto credentials) async {
    final logger = log.forMethod()..logInfo(data: credentials);
    //Mock Code
    return Success(
      RestClientResponse(
        request: RestClientRequest(
          path: '/auth/register',
          data: credentials.toJson(),
        ),
        data: '',
        statusCode: 200,
      ),
    );

    // TODO Original Code
    /*return await client
        .post(
          RestClientRequest(path: '/auth/register', data: credentials.toJson()),
        )
        .onSuccess(logger.fromSuccess)
        .onFailure(logger.fromException);*/
  }

  AsyncResult<RestClientResponse> getRefreshToken(String refreshToken) async {
    final logger = log.forMethod()..logInfo(data: refreshToken);

    return await client
        .post(
          RestClientRequest(
            path: '/auth/refresh',
            data: {'refreshToken': refreshToken},
          ),
        )
        .onFailure(logger.fromException);
  }
}
