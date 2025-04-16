import 'package:result_dart/result_dart.dart';

abstract interface class PasswordRecoverRepository {
  AsyncResult<String> getCode(int userId);
  AsyncResult<int> expireTime(int userId);
  AsyncResult<String> setCode({required int userId, required String code});
}
