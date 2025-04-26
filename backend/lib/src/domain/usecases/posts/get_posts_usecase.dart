import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../repositories/posts_repository.dart';
import '../../value_objects/posts_vo.dart';

@Component()
class GetPosts {
  final PostsRepository _postsRepository;

  GetPosts(this._postsRepository);

  AsyncResult<PostsVO> call(int page) async {
    return await _postsRepository.getPosts(page);
  }
}
