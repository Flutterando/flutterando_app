import 'dart:async';

import 'rest_client_exception.dart';
import 'rest_client_http_message.dart';
import 'rest_client_request.dart';
import 'rest_client_response.dart';

abstract interface class IClientInterceptor {
  FutureOr<RestClientHttpMessage> onResponse(RestClientResponse response);
  FutureOr<RestClientHttpMessage> onRequest(RestClientRequest request);
  FutureOr<RestClientHttpMessage> onError(RestClientException error);
}
