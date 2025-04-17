import 'package:backend/src/domain/dto/user_dto.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Component()
class UpdateUser {
  final UserRepository _userRepository;

  UpdateUser(this._userRepository);

  AsyncResult<User> call({required UserDTO dto, required User user}) async {
    return _dtoInspection(user, dto) //
        .flatMap(_userRepository.updateUser);
  }

  AsyncResult<UpdateUserDTO> _dtoInspection(User user, UserDTO dto) async {
/*     if (dto.email != null) {
      return Failure(ResponseException.badRequest('Email cannot be changed'));
    } */

    final newDTO = UserDTO(
      firstName: dto.firstName != user.firstName ? dto.firstName : null,
      lastName: dto.lastName != user.lastName ? dto.lastName : null,
      email: dto.email != user.username ? dto.email : null,
      password: dto.password != user.password ? dto.password : null,
    );
    return Success(newDTO.toUpdateDTO(user.id));
  }
}
