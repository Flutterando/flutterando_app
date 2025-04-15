import 'rest_client_http_message.dart';
import 'rest_client_request.dart';

class RestClientResponse implements RestClientHttpMessage {
  dynamic data;
  int? statusCode;
  String? message;
  RestClientRequest request;

  RestClientResponse({
    required this.request,
    this.data,
    this.statusCode,
    this.message,
  });
}
