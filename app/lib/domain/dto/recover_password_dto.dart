class RecoverPasswordDto {
  String password;
  String confirmPassword;

  RecoverPasswordDto({this.password = '', this.confirmPassword = ''});

  void setPassword(String value) => password = value;

  void setConfirmPassword(String value) => confirmPassword = value;

  Map<String, dynamic> toJson() => {'password': password};
}
