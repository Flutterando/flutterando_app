import 'package:backend/config/postgres/query_adapter.dart';
import 'package:backend/src/domain/dto/posts_create_dto.dart';
import 'package:backend/src/domain/dto/posts_update_dto.dart';
import 'package:backend/src/domain/entities/post.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/value_objects/posts_vo.dart';
import 'package:postgres/postgres.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../domain/repositories/posts_repository.dart';

@Repository()
class PostsRepositoryImpl implements PostsRepository {
  final Pool _connection;

  PostsRepositoryImpl(this._connection);

  final int limit = 40;

  @override
  AsyncResult<Posts> createPosts(SignedPostsCreateDTO dto) {
    final insertQueryMap = dto.toMapQuery();

    final String query =
        'WITH new_posts AS (${insertQueryMap.insertQuery('posts')}) '
        'SELECT '
        'new_posts.*, '
        'row_to_json(users.*)'
        'FROM new_posts '
        'JOIN users ON users.id = new_posts.users';

    return _gateway(query) //
        .flatMap(_postsResponseAdapter)
        .flatMap((list) => Success(list.first));
  }

  @override
  AsyncResult<Posts> getPost(int id) {
    final whereMap = {'posts.id': id};

    final String query = 'SELECT posts.*, row_to_json(users.*)'
        'FROM posts JOIN users ON users.id = posts.users ';

    return _gateway(query + whereMap.whereQuery()) //
        .flatMap(_postsResponseAdapter)
        .flatMap((list) => Success(list.first));
  }

  @override
  AsyncResult<PostsVO> getPosts(int page) {
    final int offset = limit * (page - 1);
    final String query = 'SELECT posts.*, row_to_json(users.*)'
        'FROM posts JOIN users ON users.id = posts.users';
    final String order =
        ' ORDER BY posts.created_at DESC LIMIT $limit OFFSET $offset';
    return _gateway(query + order) //
        .flatMap(_postsResponseAdapter)
        .flatMap((posts) => _postsVOAdapter(posts, page));
  }

  @override
  AsyncResult<Posts> updatePosts(UpdatePostsDTO dto) {
    final updateQueryMap = dto.toMapQuery();

    final String query =
        'WITH update_posts AS (${updateQueryMap.updateQuery('posts')}) '
        'SELECT '
        'update_posts.*, '
        'row_to_json(users.*)'
        'FROM update_posts '
        'JOIN users ON users.id = update_posts.users';

    return _gateway(query) //
        .flatMap(_postsResponseAdapter)
        .flatMap((list) => Success(list.first));
  }

  AsyncResult<List<Posts>> _postsResponseAdapter(
      List<Map<String, dynamic>> response) async {
    return Success(response.map(_postsAdapter).toList());
  }

  Posts _postsAdapter(Map<String, dynamic> map) {
    final author = User(
        id: map['row_to_json']['id'],
        firstName: map['row_to_json']['first_name'],
        lastName: map['row_to_json']['last_name'],
        username: map['row_to_json']['email'],
        password: '',
        roles: (map['row_to_json']['roles']).cast<String>());

    return Posts(
      id: map['id'],
      description: map['description'],
      link: map['link'],
      image: map['image'],
      imageSubtitle: map['image_subtitle'],
      author: author,
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  AsyncResult<PostsVO> _postsVOAdapter(List<Posts> posts, int page) async {
    return Success(
        PostsVO(page: page, hasMore: posts.length == limit, posts: posts));
  }

  AsyncResult<List<Map<String, dynamic>>> _gateway(String query) async {
    try {
      final response = await _connection.execute(query);
      return Success(response.map((row) => row.toColumnMap()).toList());
    } on PgException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(Exception('UserRepository gateway error: $e'));
    }
  }
}
