import 'package:vaden/vaden.dart';

@DTO()
class UserDTO {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  Map<String, dynamic> toMapQuery() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
  }

  UpdateUserDTO toUpdateDTO(int id) {
    return UpdateUserDTO(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }

  UserDTO({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });
}

class UpdateUserDTO extends UserDTO {
  final int id;
  UpdateUserDTO({
    required this.id,
    super.firstName,
    super.lastName,
    super.email,
    super.password,
  });

  Map<String, dynamic> toMapQuery() {
    return {
      'id': id,
      'first_name': super.firstName,
      'last_name': super.lastName,
      'email': super.email,
      'password': super.password,
    };
  }
}
