import 'dart:convert';

import 'package:backend/config/postgres/query_adapter.dart';
import 'package:postgres/postgres.dart' as postgres;
import 'package:redis/redis.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

import '../../domain/dto/user/user_dto.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

@Repository()
class UserRepositoryImpl implements UserRepository {
  final postgres.Pool _connection;
  final Command _redis;
  final DSON _dson;
  final PasswordEncoder _passwordEncoder;

  UserRepositoryImpl(
    this._connection,
    this._redis,
    this._dson,
    this._passwordEncoder,
  );

  final context = 'PreCreateUser';

  @override
  AsyncResult<Unit> preCreateUser(UserDTO dto) async {
    final key = context + dto.email!;
    final dtoJson = jsonEncode(_dson.toJson(dto));
    try {
      await _redis.send_object(["SET", key, dtoJson]);
      await _redis.send_object(["EXPIRE", key, "240"]);
      return Success(unit);
    } catch (e) {
      print('preCreateUser erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }

  @override
  AsyncResult<User> createUser(String email) {
    return _getRedisUser(email) //
        .flatMap(_insertQueryMap)
        .flatMap((query) => _gateway(query.insertQuery('users')))
        .flatMap(_loggedUserAdapter)
        .flatMap((users) => Success(users.first))
        .onSuccess((_) => _deleteRedisUser(email));
  }

  @override
  AsyncResult<List<User>> getUsers({String? email, int? id}) async {
    final Map<String, dynamic> whereMap = {};
    if (email != null) {
      whereMap.addAll({'email': email});
    }
    if (id != null) {
      whereMap.addAll({'id': id});
    }

    return _gateway(whereMap.selectWhereQuery('users')) //
        .flatMap(_loggedUserAdapter);
  }

  @override
  AsyncResult<User> updateUser(UserDTO dto) {
    final updateQueryMap = dto.toMapQuery();
    if (dto.password != null) {
      updateQueryMap['password'] = _passwordEncoder.encode(dto.password!);
    }

    return _gateway(updateQueryMap.updateQuery('users')) //
        .flatMap(_loggedUserAdapter)
        .flatMap((users) => Success(users.first));
  }

  AsyncResult<UserDTO> _getRedisUser(String email) async {
    final key = context + email;
    try {
      final String? result = await _redis.send_object(["GET", key]);
      if (result == null) {
        return Failure(
            ResponseException.badRequest('Email request unavailable'));
      }

      return Success(_dson.fromJson<UserDTO>(jsonDecode(result)));
    } catch (e) {
      print('_getRedisUser erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }

  AsyncResult<Unit> _deleteRedisUser(String email) async {
    final key = context + email;
    try {
      await _redis.send_object(['DEL', key]);
      return Success(unit);
    } catch (e) {
      print('_deleteRedisUser erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }

  Result<Map<String, dynamic>> _insertQueryMap(UserDTO dto) {
    final insertQueryMap = dto.toMapQuery();
    insertQueryMap['password'] = _passwordEncoder.encode(dto.password!);
    return Success(insertQueryMap);
  }

  AsyncResult<List<User>> _loggedUserAdapter(
      List<Map<String, dynamic>> response) async {
    if (response.isEmpty) {
      return Failure(ResponseException.notFound('User not found'));
    }

    List<User> list = response
        .map((row) => User(
            password: row['password'],
            id: row['id'],
            firstName: row['first_name'],
            lastName: row['last_name'],
            username: row['email'],
            roles: row['roles']))
        .toList();

    return Success(list);
  }

  AsyncResult<List<Map<String, dynamic>>> _gateway(String query) async {
    try {
      final response = await _connection.execute(query);
      return Success(response.map((row) => row.toColumnMap()).toList());
    } on postgres.PgException catch (e) {
      if (e.message
          .contains('duplicate key value violates unique constraint')) {
        return Failure(
            ResponseException.notAcceptable('Username already registered'));
      }
      return Failure(e);
    } catch (e) {
      return Failure(Exception('UserRepository gateway error: $e'));
    }
  }
}
