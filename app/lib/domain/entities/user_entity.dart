import '../enum/roles.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final List<Roles> roles;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roles
  });

  factory User.notLogged({
    required String firstName,
    required String lastName,
    required String email,
    required List<Roles> roles,
  }) = NotLoggedUser;

  factory User.logged({
    required String firstName,
    required String lastName,
    required String email,
    required List<Roles> roles,
  }) = LoggedUser;

  factory User.empty() => const User(firstName: '', lastName: '', email: '', roles: [],);
}

class LoggedUser extends User {
  LoggedUser({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.roles,
  });
}

class NotLoggedUser extends User {
  NotLoggedUser({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.roles,
  });
}
