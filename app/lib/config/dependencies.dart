import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';

import '../data/services/client_http/dio/rest_client_dio_impl.dart';
import '../data/services/client_http/i_rest_client.dart';

final injector = AutoInjector();

void setupInjector() {
  injector.add<Dio>(DioFactory.dio);
  injector.addSingleton<IRestClient>(RestClientDioImpl.new);
  injector.commit();
}