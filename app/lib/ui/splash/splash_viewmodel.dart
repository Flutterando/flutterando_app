import 'package:flutter/cupertino.dart';
import 'package:result_command/result_command.dart';

import '../../data/repositories/auth_repository.dart';

class SplashViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SplashViewmodel(this._authRepository);

  late final getLoggedUserCommand = Command0(_authRepository.getLoggedUser);
}
