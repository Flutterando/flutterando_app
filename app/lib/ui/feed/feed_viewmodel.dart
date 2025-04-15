import 'package:result_command/result_command.dart';

import '../../data/repositories/auth_repository.dart';

class FeedViewmodel {
  final AuthRepository _authRepository;

  FeedViewmodel(this._authRepository);

  late final logoutCommand = Command0(_authRepository.logout);
}