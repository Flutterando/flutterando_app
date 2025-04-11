
import '../services/api/auth_api.dart';
import '../services/storage/auth_storage.dart';

class AuthRepository {
  final AuthApi authApi;
  final AuthStorage storage;

  AuthRepository(this.authApi, this.storage);
}