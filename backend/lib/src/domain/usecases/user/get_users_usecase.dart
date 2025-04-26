import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Component()
class GetUsers {
  final UserRepository _userRepository;

  GetUsers(this._userRepository);

  AsyncResult<List<User>> call({String? email}) async {
    return await _userRepository //
        .getUsers(email: email);
  }
}
