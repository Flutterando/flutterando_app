import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Component()
class GetUser {
  final UserRepository _userRepository;

  GetUser(this._userRepository);

  AsyncResult<User> call(String userId) async {
    return await _userRepository.getUser(userId);
  }
}
