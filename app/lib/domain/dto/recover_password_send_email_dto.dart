class RecoverPasswordSendEmailDto {
  String email;

  RecoverPasswordSendEmailDto({this.email = ''});

  void setEmail(String value) => email = value;

  Map<String, dynamic> toJson() => {'email': email};
}
