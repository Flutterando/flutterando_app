import '../../domain/entities/user_entity.dart';

class UserAdapter {
  static Map<String, dynamic> toJson(User user) => {
    'firstName': user.firstName,
    'lastName': user.lastName,
    'email': user.email,
  };

  static User fromJson(Map<String, dynamic> body) {
    return User(
      firstName: body['firstName'],
      lastName: body['lastName'],
      email: body['email'],
    );
  }
}

class LoggedUserAdapter {
  static LoggedUser fromJson(Map<String, dynamic> body) {
    return LoggedUser(
      firstName: body['firstName'],
      lastName: body['lastName'],
      email: body['email'],
    );
  }
}
