import 'package:backend/config/otp/otp_service.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

import '../../dto/authentication_via_recovery_dto.dart';

@Component()
class AuthenticationViaRecoveryCode {
  final UserRepository _userRepository;
  final OtpService _otpService;
  final JwtService _jwtService;

  AuthenticationViaRecoveryCode(
    this._userRepository,
    this._otpService,
    this._jwtService,
  );

  AsyncResult<Tokenization> call(AuthenticationViaRecoveryDTO dto) async {
    final context = 'RecoverPassword';
    return _otpService //
        .checkOtp(context: context, username: dto.email, code: dto.code)
        .flatMap((_) => _userRepository.getUser(dto.email))
        .flatMap((user) => Success(_jwtService.generateToken(user)));
  }
}
