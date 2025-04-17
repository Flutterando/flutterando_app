import 'package:redis/redis.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../domain/repositories/password_recovery_repository.dart';

@Repository()
class PasswordRecoveryRepositoryImpl implements PasswordRecoveryRepository {
  final Command _redis;

  PasswordRecoveryRepositoryImpl(this._redis);

  @override
  AsyncResult<String> getCode(String username) async {
    try {
      final String? result =
          await _redis.send_object(["GET", "PasswordRecover:$username"]);
      if (result == null) {
        return Failure(
            ResponseException.badRequest('Password recovery unavailable'));
      }
      return Success(result);
    } catch (e) {
      print('PasswordRecoverRepositoryImpl erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }

  @override
  AsyncResult<String> setCode(
      {required String username, required String code}) async {
    try {
      await _redis.send_object(["SET", "PasswordRecover:$username", "$code"]);
      await _redis.send_object(["EXPIRE", "PasswordRecover:$username", "240"]);
      return Success(code);
    } catch (e) {
      print('PasswordRecoverRepositoryImpl erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }

  @override
  AsyncResult<int> expireTime(String username) async {
    try {
      final ttl =
          await _redis.send_object(["TTL", "PasswordRecover:$username"]);
      if (ttl is int && ttl < 0) {
        return Success(0);
      }
      return Success(ttl);
    } catch (e) {
      print('PasswordRecoverRepositoryImpl erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }
}
