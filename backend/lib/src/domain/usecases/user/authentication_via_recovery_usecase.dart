import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

import '../../dto/authentication_via_recovery_dto.dart';
import '../../repositories/password_recovery_repository.dart';

@Component()
class AuthenticationViaRecoveryCode {
  final UserRepository _userRepository;
  final PasswordRecoveryRepository _passwordRecoverRepository;
  final JwtService _jwtService;

  AuthenticationViaRecoveryCode(
    this._userRepository,
    this._passwordRecoverRepository,
    this._jwtService,
  );

  AsyncResult<Tokenization> call(AuthenticationViaRecoveryDTO dto) async {
    return _passwordRecoverRepository //
        .getCode(dto.email)
        .flatMap((code) => _validateCode(dto, code))
        .flatMap(_generateToken);
  }

  AsyncResult<String> _validateCode(
      AuthenticationViaRecoveryDTO dto, String code) async {
    if (code == dto.code) {
      return Success(dto.email);
    }
    return Failure(ResponseException.unauthorized('Invalid code'));
  }

  AsyncResult<Tokenization> _generateToken(String email) async {
    return _userRepository //
        .getUser(email)
        .flatMap((user) => Success(_jwtService.generateToken(user)));
  }
}
