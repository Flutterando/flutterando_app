import 'package:vaden/vaden.dart';

@DTO()
class User with Validator<User> {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  LoggedUser logged(String password) {
    return LoggedUser(
      id: id,
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  LucidValidator<User> validate(ValidatorBuilder<User> builder) {
    builder //
        .ruleFor((p) => p.id, key: 'id');

    builder //
        .ruleFor((p) => p.name, key: 'name')
        .notEmpty();

    builder //
        .ruleFor((p) => p.email, key: 'email')
        .notEmpty()
        .validEmail();

    return builder;
  }
}

class LoggedUser extends User {
  final String password;

  LoggedUser({
    required this.password,
    required super.id,
    required super.name,
    required super.email,
  });
}
