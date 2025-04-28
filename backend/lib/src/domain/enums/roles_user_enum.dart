import 'package:vaden/vaden.dart';

enum RolesUser {
  admin('admin', 'Administrador'),
  creator('creator', 'Criador de conteúdo'),
  standard('standard', 'Usuário');

  final String value;
  final String description;

  const RolesUser(this.value, this.description);

  String toMap() => value;

  factory RolesUser.fromMap(String value) => RolesUser.fromValue(value);

  factory RolesUser.fromValue(String value) {
    return switch (value) {
      'admin' => RolesUser.admin,
      'creator' => RolesUser.creator,
      'standard' => RolesUser.standard,
      _ => throw ResponseException.badRequest('Invalid user roles'),
    };
  }
}

@Parse()
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
