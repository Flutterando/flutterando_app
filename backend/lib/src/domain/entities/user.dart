import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

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
}
