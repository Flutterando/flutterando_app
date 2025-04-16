import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

import '../../dto/authentication_via_recovery_dto.dart';
import '../../entities/user.dart';
import '../../repositories/password_recover_repository.dart';

@Component()
class AuthenticationViaRecoveryCode {
  final UserRepository _userRepository;
  final PasswordRecoverRepository _passwordRecoverRepository;
  final JwtService _jwtService;

  AuthenticationViaRecoveryCode(
    this._userRepository,
    this._passwordRecoverRepository,
    this._jwtService,
  );

  AsyncResult<Tokenization> call(AuthenticationViaRecoveryDTO dto) async {
    return _validateCode(dto) //
        .flatMap((user) => Success(_jwtService.generateToken(user)));
  }

  AsyncResult<User> _validateCode(
    AuthenticationViaRecoveryDTO dto,
  ) async {
    return _userRepository //
        .getUser(dto.email)
        .flatMap((user) => _passwordRecoverRepository //
            .getCode(user.id)
            .flatMap((code) => code == dto.code
                ? Success(user)
                : Failure(ResponseException.unauthorized('Invalid code'))));
  }
}
