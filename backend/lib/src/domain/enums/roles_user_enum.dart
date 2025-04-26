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
