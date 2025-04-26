import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../dto/posts/posts_create_dto.dart';
import '../../entities/post.dart';
import '../../entities/user.dart';
import '../../repositories/posts_repository.dart';

@Component()
class CreatePosts {
  final PostsRepository _postsRepository;

  CreatePosts(
    this._postsRepository,
  );

  AsyncResult<Posts> call(
      {required PostsCreateDTO dto, required User user}) async {
    return _postsRepository.createPosts(dto.signed(user.id));
  }
}
