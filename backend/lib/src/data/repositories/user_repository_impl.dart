import 'package:backend/config/postgres/query_adapter.dart';
import 'package:postgres/postgres.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

import '../../domain/dto/user_dto.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

@Repository()
class UserRepositoryImpl implements UserRepository {
  final Pool _connection;
  final PasswordEncoder _passwordEncoder;

  UserRepositoryImpl(
    this._connection,
    this._passwordEncoder,
  );

  @override
  AsyncResult<User> createUser(UserDTO dto) {
    final insertQueryMap = dto.toMapQuery();
    insertQueryMap['password'] = _passwordEncoder.encode(dto.password!);

    return _gateway(insertQueryMap.insertQuery('users')) //
        .flatMap(_loggedUserAdapter);
  }

  @override
  AsyncResult<User> getUser(String email) async {
    final whereMap = {'email': email};

    return _gateway(whereMap.selectWhereQuery('users')) //
        .flatMap(_loggedUserAdapter);
  }

  @override
  AsyncResult<User> updateUser(UpdateUserDTO dto) {
    final updateQueryMap = dto.toMapQuery();
    if (dto.password != null) {
      updateQueryMap['password'] = _passwordEncoder.encode(dto.password!);
    }

    return _gateway(updateQueryMap.updateQuery('users')) //
        .flatMap(_loggedUserAdapter);
  }

  AsyncResult<User> _loggedUserAdapter(
      List<Map<String, dynamic>> response) async {
    if (response.isEmpty) {
      return Failure(ResponseException.notFound('User not found'));
    }

    final user = User(
        password: response.first['password'],
        id: response.first['id'],
        firstName: response.first['first_name'],
        lastName: response.first['last_name'],
        username: response.first['email'],
        roles: response.first['roles']);

    return Success(user);
  }

  AsyncResult<List<Map<String, dynamic>>> _gateway(String query) async {
    try {
      final response = await _connection.execute(query);
      return Success(response.map((row) => row.toColumnMap()).toList());
    } on PgException catch (e) {
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
