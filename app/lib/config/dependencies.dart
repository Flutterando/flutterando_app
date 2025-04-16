import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';

import '../data/repositories/auth_repository.dart';
import '../data/repositories/post_repository.dart';
import '../data/services/api/auth_api.dart';
import '../data/services/api/client_http/dio/rest_client_dio_impl.dart';
import '../data/services/api/client_http/i_rest_client.dart';
import '../data/services/api/post_api.dart';
import '../data/services/storage/auth_storage.dart';
import '../data/services/storage/local_storage/local_storage.dart';
import '../ui/auth/login/login_viewmodel.dart';
import '../ui/auth/recover_password/confirm_password/confirm_password_viewmodel.dart';
import '../ui/auth/recover_password/otp/opt_viewmodel.dart';
import '../ui/auth/recover_password/send_email/send_email_viewmodel.dart';
import '../ui/auth/register/register_viewmodel.dart';
import '../ui/post/feed/feed_viewmodel.dart';
import '../ui/post/new_post/new_post_viewmodel.dart';
import '../ui/splash/splash_viewmodel.dart';

final injector = AutoInjector();

void setupInjector() {
  injector.add<Dio>(DioFactory.dio);
  injector.addSingleton<IRestClient>(RestClientDioImpl.new);
  injector.addSingleton<LocalStorage>(LocalStorage.new);

  injector.add<AuthStorage>(AuthStorage.new);
  injector.add<AuthApi>(AuthApi.new);
  injector.add<PostApi>(PostApi.new);
  injector.addSingleton<AuthRepository>(AuthRepository.new);
  injector.addSingleton<PostRepository>(PostRepository.new);

  injector.add<LoginViewmodel>(LoginViewmodel.new);
  injector.add<RegisterViewmodel>(RegisterViewmodel.new);
  injector.add<SendEmailViewmodel>(SendEmailViewmodel.new);
  injector.add<OptViewmodel>(OptViewmodel.new);
  injector.add<ConfirmPasswordViewmodel>(ConfirmPasswordViewmodel.new);
  injector.add<FeedViewmodel>(FeedViewmodel.new);
  injector.add<NewPostViewmodel>(NewPostViewmodel.new);
  injector.add<SplashViewmodel>(SplashViewmodel.new);

  injector.commit();
}
