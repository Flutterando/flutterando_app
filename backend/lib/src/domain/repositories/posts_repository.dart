import 'package:backend/src/domain/dto/posts_update_dto.dart';
import 'package:result_dart/result_dart.dart';

import '../dto/posts_create_dto.dart';
import '../entities/post.dart';
import '../value_objects/posts_vo.dart';

abstract interface class PostsRepository {
  AsyncResult<PostsVO> getPosts(int page);
  AsyncResult<Posts> getPost(int id);
  AsyncResult<Posts> createPosts(SignedPostsCreateDTO dto);
  AsyncResult<Posts> updatePosts(UpdatePostsDTO dto);
}
