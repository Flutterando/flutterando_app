import 'package:result_dart/result_dart.dart';

import '../../domain/dto/post_dto.dart';
import '../services/api/post_api.dart';

class PostRepository {
  final PostApi _postApi;

  PostRepository(this._postApi);

  AsyncResult<Unit> createPost(PostDto dto) => //
      _postApi.createPost(dto).pure(unit);
}
