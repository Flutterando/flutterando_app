import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

import '../../domain/repositories/user_repository.dart';

@Service()
class UserDetailsServiceImpl implements UserDetailsService {
  final UserRepository _userRepository;

  UserDetailsServiceImpl(this._userRepository);

  @override
  Future<UserDetails> loadUserByUsername(String username) async {
    return _userRepository //
        .getUser(username)
        .getOrThrow();
  }
}
