import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../main.dart';
import '../../data/services/client_http/client_http.dart';
import '../constants/env.dart';

const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

Object? prettyJson(Object? data) {
  try {
    return _encoder.convert(data);
  } on JsonUnsupportedObjectError catch (_) {
    return data;
  }
}


class Log {
  late Logger logger;
  String context = '';

  Log(String className) {
    context = className;
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
      ),
    );
  }

  ScopedLog forMethod({String? methodName}) {
    final callerMethod = methodName ?? _getCallerFunctionName();
    return ScopedLog(this, callerMethod);
  }

  void logInfo({
    String? message,
    Object? data,
    String? forceContext,
    String? forceMethod,
  }) {
    if (isProduction || !debugLogger) {
      return;
    }
    final caller = forceMethod ?? _getCallerFunctionName();

    final content = message != null && message.isNotEmpty
        ? ' $message ${data != null ? ' ${jsonEncode(data)}' : ''}'
        : data != null
            ? ': ${jsonEncode(data)}'
            : '';

    logger.i(
      '[INFO] [${forceContext ?? context}] [$caller]$content',
    );
  }

  void logError({
    String? message,
    Object? data,
    Object? error,
    String? forceMethod,
  }) {
    if (isProduction || !debugLogger) {
      return;
    }
    final caller = forceMethod ?? _getCallerFunctionName();

    final content = message != null && message.isNotEmpty
        ? ' $message - ${jsonEncode(data)}'
        : data != null
            ? ' ${jsonEncode(data)}'
            : '';

    logger.e(
      '[ERROR] [$context] [$caller]$content',
    );

    if (error != null) {
      logger.e('[ERROR] [$context] [$caller]\nDetails: $error');
    }
  }

  void logDebug(String message) {
    if (isProduction || !debugLogger) {
      return;
    }
    final caller = _getCallerFunctionName();
    logger.d('[DEBUG] [$context] [$caller]: $message');
  }

  String _getCallerFunctionName() {
    final frames = Trace.current().frames;
    if (frames.length > 2) {
      return frames[2].member ?? 'Unknown';
    }
    return 'Unknown';
  }
}

class ScopedLog {
  final Log _log;
  final String _methodName;

  ScopedLog(this._log, this._methodName);

  void logInfo({String? message, Object? data}) {
    _log.logInfo(
      message: message,
      data: data,
      forceMethod: _methodName,
    );
  }

  void logError({String? message, Object? data, Object? error}) {
    _log.logError(
      message: message,
      data: data,
      error: error,
      forceMethod: _methodName,
    );
  }

  void logDebug(String message) {
    _log.logDebug(message);
  }

  void fromException(Exception exception) => logError(
        message: exception.toString(),
      );

  void fromSuccess(Object? data) {
    if (data case RestClientResponse(:final data, :final statusCode)) {
      logInfo(
        message:
            '[StatusCode: $statusCode] Success ${data != null ? '- \n${prettyJson(data)}' : ''}',
      );
      return;
    }

    logInfo(
      message: 'Success \n${data != null ? prettyJson(data) : ''}',
    );
  }
}
