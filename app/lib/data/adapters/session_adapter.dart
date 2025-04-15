import '../../domain/entities/session_entity.dart';
import 'user_adapter.dart';

class SessionAdapter {
  static Map<String, dynamic> toJson(Session session) => {
    'token': session.token,
    'refreshToken': session.refreshToken,
    'user': UserAdapter.toJson(session.user),
  };

  static fromJson(Map<String, dynamic> body) {
    return Session(
      refreshToken: body['refreshToken'],
      token: body['token'],
      user: LoggedUserAdapter.fromJson(body['user']),
    );
  }
}
