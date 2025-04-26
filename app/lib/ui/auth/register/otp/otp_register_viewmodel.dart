import 'package:result_command/result_command.dart';
import '../../../../data/repositories/auth_repository.dart';

class OtpRegisterViewmodel {
  final AuthRepository _authRepository;

  OtpRegisterViewmodel(this._authRepository);

  /*late final confirmOtpPasswordCommand = Command1(
    _authRepository.confirmOtpPassword,
  );

  late final requestToRecoverPasswordCommand = Command1(
    _authRepository.requestToRecoverPassword,
  );*/

  late final confirmOtpRegisterCodeCommand = Command1(
    _authRepository.confirmOtpRegisterCode,
  );
}
