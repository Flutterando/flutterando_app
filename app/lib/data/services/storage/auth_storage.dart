import 'dart:convert';

import 'package:result_dart/result_dart.dart';

import '../../../core/logger/logger_mixin.dart';

import '../../../domain/entities/session_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../adapters/session_adapter.dart';
import 'local_storage/local_storage.dart';

const _sessionKey = 'sessionKey';

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

  AsyncResult<LoggedUser> getUser() {
    final logger = log.forMethod();

    return _localStorage //
        .get(_sessionKey)
        .map(_toSession)
        .map((session) => session.user)
        .onSuccess(logger.fromSuccess)
        .onFailure(logger.fromException);
  }

  AsyncResult<String> getToken() {
    final logger = log.forMethod();

    return _localStorage //
        .get(_sessionKey)
        .map(_toSession)
        .map((session) => session.token)
        .onSuccess(logger.fromSuccess)
        .onFailure(logger.fromException);
  }

  AsyncResult<String> getRefreshToken() {
    final logger = log.forMethod();

    return _localStorage //
        .get(_sessionKey)
        .map(_toSession)
        .map((session) => session.refreshToken)
        .onFailure(logger.fromException);
  }

  AsyncResult<Unit> clear() {
    final logger = log.forMethod();

    return _localStorage //
        .remove(_sessionKey)
        .onFailure(logger.fromException);
  }

  Session _toSession(String json) => //
      SessionAdapter.fromJson(jsonDecode(json));
}
