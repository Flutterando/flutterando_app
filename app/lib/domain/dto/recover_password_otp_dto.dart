class RecoverPasswordOtpDto {
  String email;
  String code;

  RecoverPasswordOtpDto({this.email = '', this.code = ''});

  void setEmail(String value) => email = value;

  void setCode(String value) => code = value;

  Map<String, dynamic> toJson() => {'email': email, 'code': code};
}
