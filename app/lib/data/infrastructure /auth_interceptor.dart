import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:result_dart/result_dart.dart';

import '../repositories/auth_repository.dart';
import '../services/api/client_http/i_client_interceptor.dart';
import '../services/api/client_http/i_rest_client.dart';
import '../services/api/client_http/rest_client_exception.dart';
import '../services/api/client_http/rest_client_http_message.dart';
import '../services/api/client_http/rest_client_request.dart';
import '../services/api/client_http/rest_client_response.dart';
import '../services/storage/auth_storage.dart';

typedef RetryParams =
    ({RestClientRequest request, String token, IRestClient client});

class AuthInterceptor implements IClientInterceptor {
  final AuthStorage authStorage;
  final AuthRepository authRepository;
  final IRestClient client;
  final VoidCallback? onErrorRefreshToken;

  final int maxRetries;
  late int attempt = 0;

  AuthInterceptor({
    required this.authStorage,
    required this.authRepository,
    required this.client,
    this.maxRetries = 1,
    this.onErrorRefreshToken,
  });

  @override
  Future<RestClientRequest> onRequest(RestClientRequest request) async {
    if (request.path.contains('login') || request.path.contains('refresh')) {
      return request;
    }

    final newRequest = await authStorage
        .getToken() //
        .map((token) => 'Bearer $token')
        .map((str) => request..headers?.addAll({'Authorization': str}))
        .getOrDefault(request);

    return newRequest;
  }

  @override
  FutureOr<RestClientHttpMessage> onResponse(RestClientResponse response) {
    attempt = 0;
    return response;
  }

  AsyncResult<RestClientHttpMessage> retry(RetryParams params) async {
    final (:client, :request, :token) = params;

    request.headers?['Authorization'] = 'Bearer $token';

    try {
      return switch (request.method.toLowerCase()) {
        'get' => client.get(request),
        'post' => client.post(request),
        'put' => client.put(request),
        'delete' => client.delete(request),
        _ => client.patch(request),
      };
    } on RestClientException catch (e) {
      return Failure(e);
    }
  }

  @override
  FutureOr<RestClientHttpMessage> onError(RestClientException error) async {
    if (error.statusCode == HttpStatus.unprocessableEntity ||
        error.statusCode == HttpStatus.unauthorized ||
        error.statusCode == HttpStatus.notFound) {
      while (attempt < maxRetries) {
        final request = error.response!.request;
        request.headers?.remove('Authorization');

        try {
          attempt++;
          final result =
              await authRepository
                  .getRefreshToken() //
                  .map(
                    (token) => (request: request, token: token, client: client),
                  )
                  .flatMap(retry)
                  .getOrThrow();

          if (result is RestClientException) {
            continue;
          }

          return result;
        } on Exception catch (e, t) {
          return RestClientException(
            e.toString(),
            statusCode: error.statusCode,
            stackTracing: t,
            response: error.response,
            error: error,
            data: e,
          );
        }
      }
      onErrorRefreshToken?.call();
    }
    attempt = 0;
    return error;
  }
}
