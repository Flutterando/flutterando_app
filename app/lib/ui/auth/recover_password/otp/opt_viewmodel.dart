import 'package:result_command/result_command.dart';

import '../../../../data/repositories/auth_repository.dart';

class OptViewmodel {
  final AuthRepository _authRepository;

  OptViewmodel(this._authRepository);

  late final confirmOtpPasswordCommand = Command1(
    _authRepository.confirmOtpPassword,
  );

  late final requestToRecoverPasswordCommand = Command1(
    _authRepository.requestToRecoverPassword,
  );
}
