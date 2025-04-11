import 'rest_client_http_message.dart';

class RestClientMultipart implements RestClientHttpMessage {
  final String fileKey;
  final String fileName;
  final String path;
  final List<int>? fileBytes;

  RestClientMultipart({
    required this.fileKey,
    required this.fileName,
    required this.path,
    required this.fileBytes,
  });
}
