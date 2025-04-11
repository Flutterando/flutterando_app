import 'package:backend/src/domain/dto/update_user_dto.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class UserRepository {
  AsyncResult<User> getUser(String userId);
  AsyncResult<User> createUser(UpdateUserDto dto);
  AsyncResult<User> updateUser(UpdateUserDto dto);
}
