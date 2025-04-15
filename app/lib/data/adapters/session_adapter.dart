import '../../domain/entities/session_entity.dart';

class SessionAdapter {
  static Map<String, dynamic> toJson(Session session) => {
    'access_token': session.token,
    'refresh_token': session.refreshToken,
  };

  static fromJson(Map<String, dynamic> body) {
    return Session(refreshToken: body['refresh_token'], token: body['access_token']);
  }
}
