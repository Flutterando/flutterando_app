import 'dart:collection';

import 'package:backend/src/data/repositories/posts_repository_impl.dart';
import 'package:backend/src/domain/dto/posts/posts_create_dto.dart';
import 'package:backend/src/domain/dto/posts/posts_update_dto.dart';
import 'package:backend/src/domain/repositories/posts_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:postgres/postgres.dart' as postgres;
import 'package:test/test.dart';

class FakeResultRow extends Fake implements postgres.ResultRow {
  final Map<String, dynamic> data;
  FakeResultRow(this.data);

  @override
  Map<String, dynamic> toColumnMap() => data;
}

class FakeResult extends UnmodifiableListView<postgres.ResultRow>
    implements postgres.Result {
  final int affectedRows;
  final postgres.ResultSchema schema;

  FakeResult({
    required List<Map<String, dynamic>> data,
    this.affectedRows = 0,
    postgres.ResultSchema? schema,
  })  : schema = schema ?? postgres.ResultSchema([]),
        super(data.map((rowData) => FakeResultRow(rowData)).toList());
}

class MockPool extends Mock implements postgres.Pool {}

void main() {
  late postgres.Pool pool;
  late PostsRepository repository;

  setUp(() {
    pool = MockPool();
    repository = PostsRepositoryImpl(pool);
  });

  final nowDate = DateTime.now();
  final postDB = {
    'id': 1,
    'description': 'Test post',
    'link': 'https://example.com',
    'image': 'https://example.com/image.jpg',
    'image_subtitle': 'Test image',
    'created_at': nowDate,
    'updated_at': nowDate,
    'row_to_json': {
      'id': 1,
      'first_name': 'John',
      'last_name': 'Doe',
      'email': 'john@example.com',
      'roles': ['user']
    }
  };

  group('createPosts', () {
    final dto = SignedPostsCreateDTO(
      author: 1,
      description: 'Test post',
    );

    final String query =
        '''WITH new_posts AS (insert into posts (description,users) values ('Test post',1) RETURNING *) SELECT new_posts.*, row_to_json(users.*)FROM new_posts JOIN users ON users.id = new_posts.users''';

    test('should create a post successfully', () async {
      when(() => pool.execute(query)).thenAnswer(
          (_) async => FakeResult(data: [postDB]) as postgres.Result);

      final result = await repository.createPosts(dto);

      expect(result.isSuccess(), true);
      final post = result.getOrNull();
      expect(post, isNotNull);
      expect(post?.id, equals(1));
      expect(post?.description, equals('Test post'));
      expect(post?.author.id, equals(1));
    });

    test('should handle database error', () async {
      when(() => pool.execute(any())).thenThrow(
        postgres.PgException('database error'),
      );

      final result = await repository.createPosts(dto);

      expect(result.isError(), true);
      expect(result.exceptionOrNull(), isA<postgres.PgException>());
    });
  });

  group('getPost', () {
    final String query =
        '''SELECT posts.*, row_to_json(users.*)FROM posts JOIN users ON users.id = posts.users  where posts.id = 1''';

    test('should get a post successfully', () async {
      when(() => pool.execute(query)).thenAnswer(
          (_) async => FakeResult(data: [postDB]) as postgres.Result);

      final result = await repository.getPost(1);

      expect(result.isSuccess(), true);
      final post = result.getOrNull();
      expect(post, isNotNull);
      expect(post?.id, equals(1));
      expect(post?.description, equals('Test post'));
      expect(post?.author.id, equals(1));
    });

    test('should handle database error', () async {
      when(() => pool.execute(any())).thenThrow(
        postgres.PgException('database error'),
      );

      final result = await repository.getPost(1);

      expect(result.isError(), true);
      expect(result.exceptionOrNull(), isA<postgres.PgException>());
    });
  });

  group('getPosts', () {
    final String query =
        '''SELECT posts.*, row_to_json(users.*)FROM posts JOIN users ON users.id = posts.users ORDER BY posts.created_at DESC LIMIT 40 OFFSET 0''';

    List<Map<String, dynamic>> response(int size) {
      return List.generate(size, (index) {
        Map<String, Object> post = Map.from(postDB);
        post['id'] = index + 1;
        return post;
      });
    }

    test('should get posts successfully with hasMore true', () async {
      when(() => pool.execute(query)).thenAnswer(
          (_) async => FakeResult(data: response(40)) as postgres.Result);

      final result = await repository.getPosts(1);

      expect(result.isSuccess(), true);
      final postsVO = result.getOrNull();
      expect(postsVO, isNotNull);
      expect(postsVO?.posts.length, equals(40));
      expect(postsVO?.hasMore, equals(true));
      expect(postsVO?.page, equals(1));
    });

    test('should get posts successfully with hasMore false', () async {
      when(() => pool.execute(query)).thenAnswer(
          (_) async => FakeResult(data: response(20)) as postgres.Result);

      final result = await repository.getPosts(1);

      expect(result.isSuccess(), true);
      final postsVO = result.getOrNull();
      expect(postsVO, isNotNull);
      expect(postsVO?.posts.length, equals(20));
      expect(postsVO?.hasMore, equals(false));
      expect(postsVO?.page, equals(1));
    });

    test('should handle database error', () async {
      when(() => pool.execute(any())).thenThrow(
        postgres.PgException('database error'),
      );

      final result = await repository.getPost(1);

      expect(result.isError(), true);
      expect(result.exceptionOrNull(), isA<postgres.PgException>());
    });
  });

  group('updatePosts', () {
    final dto = UpdatePostsDTO(
      id: 1,
      description: 'Updated post',
      link: 'https://updated.com',
    );

    final String query =
        '''WITH update_posts AS (update posts  set description = 'Updated post', link = 'https://updated.com'  where id = 1  RETURNING *) SELECT update_posts.*, row_to_json(users.*)FROM update_posts JOIN users ON users.id = update_posts.users''';

    test('should update a post successfully', () async {
      when(() => pool.execute(query)).thenAnswer(
          (_) async => FakeResult(data: [postDB]) as postgres.Result);

      final result = await repository.updatePosts(dto);

      expect(result.isSuccess(), true);
      final post = result.getOrNull();
      expect(post, isNotNull);
      expect(post?.id, equals(1));
      expect(post?.description, equals('Test post'));
      expect(post?.author.id, equals(1));
    });

    test('should handle database error', () async {
      when(() => pool.execute(any())).thenThrow(
        postgres.PgException('database error'),
      );

      final result = await repository.updatePosts(dto);

      expect(result.isError(), true);
      expect(result.exceptionOrNull(), isA<postgres.PgException>());
    });
  });
}
