import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';

import '../data/repositories/auth_repository.dart';
import '../data/services/api/auth_api.dart';
import '../data/services/api/client_http/dio/rest_client_dio_impl.dart';
import '../data/services/api/client_http/i_rest_client.dart';
import '../data/services/storage/auth_storage.dart';
import '../data/services/storage/local_storage/local_storage.dart';
import '../ui/auth/login/login_viewmodel.dart';
import '../ui/auth/recover_password/confirm_password/confirm_password_viewmodel.dart';
import '../ui/auth/recover_password/otp/opt_viewmodel.dart';
import '../ui/auth/recover_password/send_email/send_email_viewmodel.dart';
import '../ui/auth/register/register_viewmodel.dart';
import '../ui/feed/feed_viewmodel.dart';

final injector = AutoInjector();

void setupInjector() {
  injector.add<Dio>(DioFactory.dio);
  injector.addSingleton<IRestClient>(RestClientDioImpl.new);
  injector.addSingleton<LocalStorage>(LocalStorage.new);

  injector.addSingleton<AuthStorage>(AuthStorage.new);
  injector.addSingleton<AuthApi>(AuthApi.new);
  injector.addSingleton<AuthRepository>(AuthRepository.new);

  injector.addSingleton<LoginViewmodel>(LoginViewmodel.new);
  injector.addSingleton<RegisterViewmodel>(RegisterViewmodel.new);
  injector.addSingleton<SendEmailViewmodel>(SendEmailViewmodel.new);
  injector.addSingleton<OptViewmodel>(OptViewmodel.new);
  injector.addSingleton<ConfirmPasswordViewmodel>(ConfirmPasswordViewmodel.new);
  injector.addSingleton<FeedViewmodel>(FeedViewmodel.new);

  injector.commit();
}
