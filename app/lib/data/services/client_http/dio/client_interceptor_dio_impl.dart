import 'dio_adapter.dart';
import '../i_client_interceptor.dart';
import '../rest_client_exception.dart';
import '../rest_client_request.dart';
import '../rest_client_response.dart';
import 'package:dio/dio.dart';

class ClientInterceptorDioImpl implements Interceptor {
  final IClientInterceptor interceptor;

  ClientInterceptorDioImpl({required this.interceptor});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final restClientHttp = DioAdapter.toClientException(err);
    final message = await interceptor.onError(restClientHttp);

    if (message is RestClientException) {
      handler.next(DioAdapter.toDioException(message));
    } else if (message is RestClientResponse) {
      handler.resolve(DioAdapter.toResponse(message));
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final restRequest = DioAdapter.toClientRequest(options);
    final message = await interceptor.onRequest(restRequest);

    if (message is RestClientException) {
      handler.reject(DioAdapter.toDioException(message));
    } else if (message is RestClientRequest) {
      handler.next(DioAdapter.toRequestOptions(message));
    } else if (message is RestClientResponse) {
      handler.resolve(DioAdapter.toResponse(message));
    }
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    final restResponse = DioAdapter.toClientResponse(response);
    final message = await interceptor.onResponse(restResponse);

    if (message is RestClientException) {
      handler.reject(DioAdapter.toDioException(message));
    } else if (message is RestClientResponse) {
      handler.next(DioAdapter.toResponse(message));
    }
  }
}
