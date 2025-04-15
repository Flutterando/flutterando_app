import 'package:backend/src/domain/dto/user_dto.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Component()
class CreateUser {
  final UserRepository _userRepository;

  CreateUser(this._userRepository);

  AsyncResult<User> call(UserDTO dto) async {
    return await _userRepository.createUser(dto);
  }
}
