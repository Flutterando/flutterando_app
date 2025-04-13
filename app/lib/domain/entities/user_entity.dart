class User {
  final String firstName;
  final String lastName;
  final String email;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.notLogged({
    required String firstName,
    required String lastName,
    required String email,
  }) = NotLoggedUser;

  factory User.logged({
    required String firstName,
    required String lastName,
    required String email,
  }) = LoggedUser;

  factory User.empty() => const User(firstName: '', lastName: '', email: '');
}

class LoggedUser extends User {
  LoggedUser({
    required super.firstName,
    required super.lastName,
    required super.email,
  });
}

class NotLoggedUser extends User {
  NotLoggedUser({
    required super.firstName,
    required super.lastName,
    required super.email,
  });
}
