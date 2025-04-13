import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/exceptions.dart';

class LocalStorage {
  AsyncResult<Unit> save(String key, String value) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.setString(key, value);

      return const Success(unit);
    } on Exception catch (e, s) {
      return Failure(StorageException(e.toString(), s));
    }
  }

  AsyncResult<String> get(String key) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final value = shared.getString(key);

      if (value == null) {
        return Failure(StorageException('$key not found'));
      }

      return Success(value);
    } on Exception catch (e, s) {
      return Failure(StorageException(e.toString(), s));
    }
  }

  AsyncResult<Unit> remove(String userKey) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.remove(userKey);
      return const Success(unit);
    } on Exception catch (e, s) {
      return Failure(StorageException(e.toString(), s));
    }
  }
}
