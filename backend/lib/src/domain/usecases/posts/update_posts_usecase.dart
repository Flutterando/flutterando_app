import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../dto/posts/posts_update_dto.dart';
import '../../entities/post.dart';
import '../../entities/user.dart';
import '../../repositories/posts_repository.dart';

@Component()
class UpdatePosts {
  final PostsRepository _postsRepository;

  UpdatePosts(
    this._postsRepository,
  );

  AsyncResult<Posts> call(
      {required UpdatePostsDTO dto, required User user}) async {
    return _postsRepository //
        .getPost(dto.id)
        .flatMap((post) => _postAuthorValidation(post, user))
        .flatMap((post) => _dtoInspection(post, dto))
        .flatMap(_postsRepository.updatePosts);
  }

  AsyncResult<Posts> _postAuthorValidation(Posts post, User user) async {
    if (user.id == post.author.id) {
      return Success(post);
    }
    return Failure(
        ResponseException.forbidden('Permission denied to edit this post'));
  }

  AsyncResult<UpdatePostsDTO> _dtoInspection(
      Posts post, UpdatePostsDTO dto) async {
    final newDTO = UpdatePostsDTO(
      id: dto.id,
      description: dto.description != post.description ? dto.description : null,
      link: dto.link != post.link ? dto.link : null,
      image: dto.image != post.image ? dto.image : null,
      imageSubtitle:
          dto.imageSubtitle != post.imageSubtitle ? dto.imageSubtitle : null,
    );
    return Success(newDTO);
  }
}
