import 'package:dio/dio.dart';

import 'rest_client_http_message.dart';

class CancelRequest {
  final CancelToken _cancelToken;

  CancelRequest() : _cancelToken = CancelToken();

  CancelToken get token => _cancelToken;

  void cancel([String? reason]) {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel(reason);
    }
  }

  bool get isCancelled => _cancelToken.isCancelled;
}

class RestClientRequest implements RestClientHttpMessage {
  final String path;
  final dynamic data;
  final String method;
  final String baseUrl;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;
  final CancelRequest? cancelRequest;

  RestClientRequest({
    required this.path,
    this.data,
    this.queryParameters,
    this.headers,
    this.method = 'GET',
    this.baseUrl = '',
    this.cancelRequest,
  });

  RestClientRequest copyWith({
    String? path,
    dynamic data,
    String? method,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return RestClientRequest(
      path: path ?? this.path,
      data: data ?? this.data,
      method: method ?? this.method,
      queryParameters: queryParameters ?? this.queryParameters,
      headers: headers ?? this.headers,
    );
  }
}
