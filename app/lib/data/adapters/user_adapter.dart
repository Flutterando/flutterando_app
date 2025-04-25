import '../../domain/entities/user_entity.dart';
import '../../domain/enum/roles.dart';

class LoggedUserAdapter {
  static LoggedUser fromJson(Map<String, dynamic> body) {
    return LoggedUser(
      firstName: body['firstName'],
      lastName: body['lastName'],
      email: body['username'],
      roles: (body['roles'] as List).map((e) => Roles.fromString(e as String)).toList(),
    );
  }

  static Map<String, dynamic> toJson(LoggedUser body) => //
      {
    'firstName': body.firstName,
    'lastName': body.lastName,
    'username': body.email,
    'roles': body.roles.map((e) => e.toString()).toList(),
  };
}
