class CredentialsLoginDto {
  String email;
  String password;

  CredentialsLoginDto({this.email = '', this.password = ''});

  factory CredentialsLoginDto.withTestUser() =>
      CredentialsLoginDto(email: 'jacobinho@gmail.com', password: 'Teste@1234');

  void setEmail(String value) => email = value;

  void setPassword(String value) => password = value;

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
