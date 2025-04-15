import 'package:backend/src/domain/dto/user_dto.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class UserRepository {
  AsyncResult<User> getUser(String email);
  AsyncResult<User> createUser(UserDTO dto);
  AsyncResult<User> updateUser(UpdateUserDTO dto);
}
