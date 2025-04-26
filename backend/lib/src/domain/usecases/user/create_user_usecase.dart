import 'package:backend/config/otp/otp_service.dart';
import 'package:backend/src/domain/dto/user/user_dto.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Component()
class CreateUser {
  final UserRepository _userRepository;
  final OtpService _otpService;

  CreateUser(
    this._userRepository,
    this._otpService,
  );

  AsyncResult<Unit> call(UserDTO dto) async {
    final context = 'CreateUser';
    return _otpService //
        .sendOtp(context: context, userDto: dto)
        .flatMap((_) => _userRepository.preCreateUser(dto));
  }
}
