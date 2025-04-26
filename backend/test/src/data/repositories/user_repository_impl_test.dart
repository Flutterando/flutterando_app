import 'dart:collection';
import 'dart:convert';

import 'package:backend/src/data/repositories/user_repository_impl.dart';
import 'package:backend/src/domain/dto/user/user_dto.dart';
import 'package:backend/src/domain/enums/roles_user_enum.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:redis/redis.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:postgres/postgres.dart' as postgres;
import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

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

class MockCommand extends Mock implements Command {}

class FakeDSON extends Fake implements DSON {
  final UserDTO dto;

  FakeDSON(this.dto);

  @override
  Map<String, dynamic> toJson<T>(T object) => dto.toMapQuery();

  @override
  UserDTO fromJson<UserDTO>(Map<String, dynamic> json) => dto as UserDTO;
}

class MockPasswordEncoder extends Mock implements PasswordEncoder {}

void main() {
  late postgres.Pool pool;
  late Command redis;
  late DSON dson;
  late PasswordEncoder encoder;
  late UserRepository repository;

  const testEmail = 'test@example.com';
  const testPassword = '123456';

  final testUserDTO = UserDTO(
    id: 1,
    firstName: 'John',
    lastName: 'Doe',
    email: testEmail,
    password: testPassword,
    roles: [RolesUser.admin],
  );

  final encodedPassword = 'encoded_password';

  final userMap = {
    'id': 1,
    'first_name': 'John',
    'last_name': 'Doe',
    'email': testEmail,
    'password': encodedPassword,
    'roles': ['admin'],
  };

  setUp(() {
    pool = MockPool();
    redis = MockCommand();
    dson = FakeDSON(testUserDTO);
    encoder = MockPasswordEncoder();
    repository = UserRepositoryImpl(pool, redis, dson, encoder);
  });

  group('preCreateUser', () {
    test('should store DTO in Redis and return success', () async {
      when(() => redis.send_object(any())).thenAnswer((_) async => null);

      final result = await repository.preCreateUser(testUserDTO);

      expect(result.isSuccess(), isTrue);
    });

    test('should return failure on Redis error', () async {
      when(() => redis.send_object(any()))
          .thenThrow(Exception('Redis failure'));

      final result = await repository.preCreateUser(testUserDTO);

      expect(result.isError(), isTrue);
    });
  });

  group('createUser', () {
    setUp(() {
      when(() => encoder.encode(any())).thenAnswer((_) => encodedPassword);
    });

    test('should create user from redis and return user', () async {
      when(() => redis.send_object(['GET', 'PreCreateUser$testEmail']))
          .thenAnswer((_) async => jsonEncode(testUserDTO.toMapQuery()));

      when(() => redis.send_object(['DEL', 'PreCreateUser$testEmail']))
          .thenAnswer((_) async => null);

      when(() => pool.execute(any())).thenAnswer(
        (_) async => FakeResult(data: [userMap]),
      );

      final result = await repository.createUser(testEmail);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.username, equals(testEmail));
    });

    test('should return failure when redis GET returns null', () async {
      when(() => redis.send_object(['GET', 'PreCreateUser$testEmail']))
          .thenAnswer((_) async => null);

      final result = await repository.createUser(testEmail);

      expect(result.isError(), isTrue);
    });
  });

  group('getUsers', () {
    test('should return user list on success', () async {
      when(() => pool.execute(any())).thenAnswer(
        (_) async => FakeResult(data: [userMap]),
      );

      final result = await repository.getUsers(email: testEmail);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.first.username, equals(testEmail));
    });

    test('should return failure if no users found', () async {
      when(() => pool.execute(any())).thenAnswer(
        (_) async => FakeResult(data: []),
      );

      final result = await repository.getUsers(email: testEmail);

      expect(result.isError(), isTrue);
    });
  });

  group('updateUser', () {
    test('should update user and return updated user', () async {
      when(() => encoder.encode(any())).thenReturn(encodedPassword);
      when(() => pool.execute(any())).thenAnswer(
        (_) async => FakeResult(data: [userMap]),
      );

      final result = await repository.updateUser(testUserDTO);

      expect(result.isSuccess(), isTrue);
      expect(result.getOrNull()?.username, equals(testEmail));
    });
  });
}
