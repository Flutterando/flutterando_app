import 'package:backend/config/otp/otp_service.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Component()
class SendRecoverPasswordEmail {
  final UserRepository _userRepository;
  final OtpService _otpService;
  SendRecoverPasswordEmail(
    this._userRepository,
    this._otpService,
  );

  AsyncResult<Unit> call(String email) async {
    final context = 'RecoverPassword';
    return _otpService //
        .statusOtp(context: context, username: email)
        .flatMap((_) => _userRepository.getUser(email))
        .flatMap((user) => _otpService.sendOtp(context: context, user: user));
  }
}
