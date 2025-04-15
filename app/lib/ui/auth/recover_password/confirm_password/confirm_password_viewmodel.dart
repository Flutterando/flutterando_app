import 'package:result_command/result_command.dart';

import '../../../../data/repositories/auth_repository.dart';

class ConfirmPasswordViewmodel {
  final AuthRepository _authRepository;

  ConfirmPasswordViewmodel(this._authRepository);

  late final newPasswordCommand = Command1(_authRepository.newPassword);
}
