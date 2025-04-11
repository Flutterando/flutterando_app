import 'i_client_interceptor.dart';
import 'rest_client_multipart.dart';
import 'rest_client_request.dart';
import 'rest_client_response.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class IRestClient {
  AsyncResult<RestClientResponse> post(RestClientRequest request);

  AsyncResult<RestClientResponse> get(RestClientRequest request);

  AsyncResult<RestClientResponse> put(RestClientRequest request);

  AsyncResult<RestClientResponse> delete(RestClientRequest request);

  AsyncResult<RestClientResponse> patch(RestClientRequest request);

  AsyncResult<RestClientResponse> upload(RestClientMultipart multipart);

  void addInterceptors(IClientInterceptor interceptor);

  void removeInterceptors(IClientInterceptor interceptor);
}
