import 'package:result_dart/result_dart.dart';

abstract interface class PasswordRecoverRepository {
  AsyncResult<String> getCode(String username);
  AsyncResult<int> expireTime(String username);
  AsyncResult<String> setCode({required String username, required String code});
}
