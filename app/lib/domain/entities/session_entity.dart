class Session {
  final String token;
  final String refreshToken;

  Session({
    required this.refreshToken,
    required this.token,
  });
}
