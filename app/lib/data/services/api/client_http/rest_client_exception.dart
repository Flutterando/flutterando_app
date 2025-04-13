import '../../../../core/exceptions/exceptions.dart';
import 'rest_client_http_message.dart';
import 'rest_client_response.dart';

class RestClientException extends BaseException
    implements RestClientHttpMessage {
  RestClientResponse? response;

  final dynamic error;
  final dynamic data;
  final int? statusCode;
  final dynamic stackTracing;

  RestClientException(
    super.message, {
    required this.error,
    this.data,
    this.statusCode,
    this.stackTracing,
    this.response,
  });

  factory RestClientException.fromBaseException(BaseException exception) {
    return RestClientException(exception.message, error: exception);
  }

  @override
  String toString() {
    return 'RestClientException{\nmessage: \'${super.message}\', \nresponse: $response,\n error: $error,\n data: $data,\n statusCode: $statusCode,\n stackTracing: $stackTracing\n}';
  }
}
