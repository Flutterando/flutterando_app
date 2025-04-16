import 'package:result_dart/result_dart.dart';

import '../../../core/logger/logger_mixin.dart';
import '../../../domain/dto/post_dto.dart';
import 'client_http/i_rest_client.dart';
import 'client_http/rest_client_request.dart';
import 'client_http/rest_client_response.dart';

class PostApi with LoggerMixin {
  final IRestClient client;

  PostApi(this.client);

  AsyncResult<RestClientResponse> createPost(PostDto dto) async {
    final logger = log.forMethod()..logInfo(data: dto);

    return await client
        .post(RestClientRequest(path: '/posts', data: dto.toJson()))
        .onSuccess(logger.fromSuccess)
        .onFailure(logger.fromException);
  }

  AsyncResult<RestClientResponse> getPosts() async {
    final logger = log.forMethod();

    return await client
        .get(RestClientRequest(path: '/posts'))
        .onSuccess(logger.fromSuccess)
        .onFailure(logger.fromException);
  }
}
