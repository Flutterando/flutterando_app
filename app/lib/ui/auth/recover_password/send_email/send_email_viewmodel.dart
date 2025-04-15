import 'package:result_command/result_command.dart';

import '../../../../data/repositories/auth_repository.dart';

class SendEmailViewmodel {
  final AuthRepository _authRepository;

  SendEmailViewmodel(this._authRepository);

  late final requestToRecoverPasswordCommand = Command1(
    _authRepository.requestToRecoverPassword,
  );
}
