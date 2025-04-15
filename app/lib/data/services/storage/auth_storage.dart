import 'dart:convert';

import 'package:result_dart/result_dart.dart';

import '../../../core/logger/logger_mixin.dart';

import '../../../domain/entities/session_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../adapters/session_adapter.dart';
import '../../adapters/user_adapter.dart';
import 'local_storage/local_storage.dart';

const _sessionKey = 'sessionKey';
const _userKey = 'userKey';

class AuthStorage with LoggerMixin {
  final LocalStorage _localStorage;

  AuthStorage(this._localStorage);

  AsyncResult<Session> saveSession(Session session) {
    final logger = log.forMethod();

    return _localStorage //
        .save(_sessionKey, jsonEncode(SessionAdapter.toJson(session)))
        .onFailure(logger.fromException)
        .pure(session);
  }

  AsyncResult<LoggedUser> saveUser(LoggedUser user) {
    final logger = log.forMethod();

    return _localStorage //
        .save(_userKey, jsonEncode(LoggedUserAdapter.toJson(user)))
        .onFailure(logger.fromException)
        .pure(user);
  }

  AsyncResult<LoggedUser> getUser() {
    final logger = log.forMethod();

    return _localStorage //
        .get(_userKey)
        .map(_toUserEntity)
        .onSuccess(logger.fromSuccess)
        .onFailure(logger.fromException);
  }

  AsyncResult<String> getToken() {
    final logger = log.forMethod();

    return _localStorage //
        .get(_sessionKey)
        .map(_toSessionEntity)
        .map((session) => session.token)
        .onSuccess(logger.fromSuccess)
        .onFailure(logger.fromException);
  }

  AsyncResult<String> getRefreshToken() {
    final logger = log.forMethod();

    return _localStorage //
        .get(_sessionKey)
        .map(_toSessionEntity)
        .map((session) => session.refreshToken)
        .onFailure(logger.fromException);
  }

  AsyncResult<Unit> clear() {
    final logger = log.forMethod();

    return _localStorage //
        .remove(_sessionKey)
        .onFailure(logger.fromException);
  }

  Session _toSessionEntity(String json) => //
      SessionAdapter.fromJson(jsonDecode(json));

  LoggedUser _toUserEntity(String json) => //
      LoggedUserAdapter.fromJson(jsonDecode(json));
}
