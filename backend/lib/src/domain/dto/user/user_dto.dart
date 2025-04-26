import 'package:backend/src/domain/enums/roles_user_enum.dart';
import 'package:vaden/vaden.dart';

@DTO()
class UserDTO {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  @UseParse(RolesUserParse)
  final List<RolesUser>? roles;

  Map<String, dynamic> toMapQuery() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'roles': stringRoles()
    };
  }

  UserDTO toUpdateDTO(int id) {
    return UserDTO(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      roles: roles,
    );
  }

  List<String>? stringRoles() {
    return roles == null ? null : roles!.map((role) => role.toMap()).toList();
  }

  UserDTO({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.roles,
  });
}

class RolesUserParse extends ParamParse<List<RolesUser>?, List<String>?> {
  const RolesUserParse();

  @override
  List<String>? toJson(List<RolesUser>? param) {
    return param?.map((r) => r.toMap()).toList();
  }

  @override
  List<RolesUser>? fromJson(List<String>? json) {
    return json?.map((r) => RolesUser.fromMap(r)).toList();
  }
}
