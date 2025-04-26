import 'package:backend/src/domain/dto/user/user_dto.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../enums/roles_user_enum.dart';

@Component()
class UpdateUser {
  final UserRepository _userRepository;

  UpdateUser(this._userRepository);

  AsyncResult<User> call({required UserDTO dto, User? user}) async {
    if (dto.id == null && user == null) {
      return Failure(ResponseException.badRequest('Unidentified user'));
    }
    if (user != null) {
      return _dtoInspection(user, dto) //
          .flatMap(_userRepository.updateUser);
    }
    return _userRepository //
        .getUsers(id: dto.id)
        .flatMap((users) => _dtoInspection(users.first, dto))
        .flatMap(_userRepository.updateUser);
  }

  AsyncResult<UserDTO> _dtoInspection(User user, UserDTO dto) async {
    final newDTO = UserDTO(
      firstName: dto.firstName != user.firstName ? dto.firstName : null,
      lastName: dto.lastName != user.lastName ? dto.lastName : null,
      email: dto.email != user.username ? dto.email : null,
      password: dto.password != user.password ? dto.password : null,
      roles: _roles(user, dto),
    );
    return Success(newDTO.toUpdateDTO(user.id));
  }

  List<RolesUser>? _roles(User user, UserDTO dto) {
    if (dto.roles == null) return null;

    final dtoRoles = List.from(dto.stringRoles()!);
    final userRoles = List.from(user.roles);

    dtoRoles.sort();
    userRoles.sort();

    for (int i = 0; i < dtoRoles.length; i++) {
      if (dtoRoles[i] != userRoles[i]) return dto.roles;
    }

    return null;
  }
}
