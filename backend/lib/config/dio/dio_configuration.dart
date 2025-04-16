import 'package:dio/dio.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class DioConfiguration {
  @Bean()
  Dio config(ApplicationSettings settings) {
    return Dio();
  }
}
