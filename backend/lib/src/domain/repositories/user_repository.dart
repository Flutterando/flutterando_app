import 'package:backend/src/domain/dto/user/user_dto.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class UserRepository {
  AsyncResult<List<User>> getUsers({String? email, int? id});
  AsyncResult<Unit> preCreateUser(UserDTO dto);
  AsyncResult<User> createUser(String email);
  AsyncResult<User> updateUser(UserDTO dto);
}
