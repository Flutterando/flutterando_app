import 'package:backend/src/domain/dto/update_user_dto.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Component()
class CreateUserUsecase {
  final UserRepository _userRepository;

  CreateUserUsecase(this._userRepository);

  AsyncResult<User> call(UpdateUserDto dto) async {
    return await _userRepository.createUser(dto);
  }
}
