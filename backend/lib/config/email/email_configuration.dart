import 'package:backend/config/email/email_service.dart';
import 'package:dio/dio.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class EmailConfiguration {
  @Bean()
  EmailService emailService(Dio dio, ApplicationSettings settings) {
    return EmailService(
        fromEmail: 'app@flutterando.com.br',
        fromName: 'Flotterando App',
        settings: settings,
        dio: dio);
  }
}
