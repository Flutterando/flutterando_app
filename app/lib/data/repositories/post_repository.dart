import 'dart:async';

import 'package:result_dart/result_dart.dart';

import '../../domain/dto/post_dto.dart';
import '../../domain/entities/post_entity.dart';
import '../adapters/post_adapter.dart';
import '../services/api/client_http/rest_client_response.dart';
import '../services/api/post_api.dart';

class PostRepository {
  final PostApi _postApi;

  PostRepository(this._postApi);

  late final StreamController<List<Post>> _streamPosts =
      StreamController.broadcast();

  Stream<List<Post>> observerListPost() => _streamPosts.stream;

  AsyncResult<Unit> createPost(PostDto dto) => //
      _postApi //
      .createPost(dto)
      .pure(unit)
      .onSuccess((_) => getPosts());

  AsyncResult<List<Post>> getPosts() => //
      _postApi //
      .getPosts()
      .map(_toListPostEntity)
      .onSuccess(_notifyLastTaskList);

  void _notifyLastTaskList(List<Post> posts) => //
      _streamPosts.add(posts);

  List<Post> _toListPostEntity(RestClientResponse response) {
    if (response.data['posts'] is! List) {
      return [];
    }

    final posts =
        (response.data['posts'] as List)
            .map((data) => PostAdapter.fromJson(data))
            .toList();

    return posts;
  }
}
