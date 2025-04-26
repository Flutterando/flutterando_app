import 'package:backend/src/domain/enums/roles_user_enum.dart';
import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

import '../dto/user/user_dto.dart';

@DTO()
class User extends UserDetails {
  final int id;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required super.username,
    required super.password,
    required super.roles,
  });

  List<RolesUser> enumRoles() {
    return super.roles.map((role) => RolesUser.fromMap(role)).toList();
  }

  bool isAdmin() => enumRoles().contains(RolesUser.admin);
  bool isCreator() => enumRoles().contains(RolesUser.creator);

  UserDTO toDto() {
    return UserDTO(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: username,
      password: password,
      roles: enumRoles(),
    );
  }
}
