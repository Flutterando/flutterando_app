abstract class BaseException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  BaseException(this.message, [this.stackTrace]);

  @override
  String toString() {
    final text = '$runtimeType: $message';

    if (stackTrace != null) {
      return '$text\n$stackTrace';
    }

    return text;
  }
}

class DataException extends BaseException {
  DataException(super.message, [super.stackTrace]);
}

class StorageException extends DataException {
  StorageException(super.message, [super.stackTrace]);
}

class LoginException extends DataException {
  LoginException(super.message, [super.stackTrace]);
}
