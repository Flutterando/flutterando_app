import 'package:result_command/result_command.dart';
import '../../../data/repositories/auth_repository.dart';

class RegisterViewmodel {
  final AuthRepository _authRepository;

  RegisterViewmodel(this._authRepository);

  late final registerCommand = Command1(_authRepository.register);
}
