import 'dart:math';

import 'package:backend/config/otp/otp_sender.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:redis/redis.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

class OtpService {
  final Command redis;
  final OtpSender sender;

  OtpService({
    required this.redis,
    required this.sender,
  });

  String key(String context, String username) => 'otp:context:username';

  AsyncResult<Unit> statusOtp({
    required String context,
    required String username,
  }) {
    return _validationRequest(key(context, username));
  }

  AsyncResult<Unit> sendOtp({
    required String context,
    required User user,
  }) {
    final _key = key(context, user.username);
    return _validationRequest(_key) //
        .flatMap((_) => Success(_codeGenerator(4)))
        .flatMap((code) => _setCode(code, _key))
        .flatMap((code) => sender.sendOtp(user: user, code: code));
  }

  AsyncResult<Unit> checkOtp({
    required String context,
    required String username,
    required String code,
  }) {
    return _getCode(key(context, username)) //
        .flatMap((verification) => _validateCode(verification, code))
        .flatMap((_) => _deleteCode(key(context, username)));
  }

  String _codeGenerator(int digits) {
    final random = Random();

    int min = pow(10, digits - 1).toInt();
    int max = pow(10, digits).toInt() - 1;

    return '${min + random.nextInt(max - min)}';
  }

  Result<Unit> _validateCode(String verification, String code) {
    if (code == verification) {
      return Success(unit);
    }
    return Failure(ResponseException.unauthorized('Invalid code'));
  }

  AsyncResult<String> _getCode(String key) async {
    try {
      final String? result = await redis.send_object(["GET", key]);
      if (result == null) {
        return Failure(
            ResponseException.badRequest('User request unavailable'));
      }
      return Success(result);
    } catch (e) {
      print('OtpService erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }

  AsyncResult<String> _setCode(String code, String key) async {
    try {
      await redis.send_object(["SET", key, code]);
      await redis.send_object(["EXPIRE", key, "240"]);
      return Success(code);
    } catch (e) {
      print('OtpService erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }

  AsyncResult<Unit> _deleteCode(String key) async {
    try {
      await redis.send_object(['DEL', key]);
      return Success(unit);
    } catch (e) {
      print('OtpService erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }

  AsyncResult<Unit> _validationRequest(String key) async {
    try {
      final ttl = await redis.send_object(["TTL", key]);
      if (ttl is int && ttl > 120) {
        return Failure(ResponseException.notAcceptable(
            'The request was sent to fewer than two minutes'));
      }
      return Success(unit);
    } catch (e) {
      print('OtpService erro: $e');
      return Failure(e is Exception ? e : Exception(e));
    }
  }
}
