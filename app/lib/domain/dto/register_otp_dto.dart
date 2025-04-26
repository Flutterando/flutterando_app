class RegisterOtpDto {

  String email;
  String code;

  RegisterOtpDto({this.email = '', this.code = ''});

  Map<String, dynamic> toJson() => {'email': email, 'code': code};

}