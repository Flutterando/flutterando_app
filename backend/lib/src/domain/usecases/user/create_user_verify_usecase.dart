import 'package:backend/config/otp/otp_service.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../dto/email_otp_verification_dto.dart';

@Component()
class CreateUserVerify {
  final UserRepository _userRepository;
  final OtpService _otpService;

  CreateUserVerify(
    this._userRepository,
    this._otpService,
  );

  AsyncResult<User> call(EmailOtpVerificationDTO dto) async {
    final context = 'CreateUser';
    return _otpService //
        .checkOtp(context: context, username: dto.email, code: dto.code)
        .flatMap((_) => _userRepository.createUser(dto.email));
  }
}
