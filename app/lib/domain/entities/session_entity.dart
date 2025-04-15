import 'user_entity.dart';

class Session {
  final String token;
  final String refreshToken;
  final LoggedUser user;

  Session({
    required this.refreshToken,
    required this.token,
    required this.user,
  });
}
