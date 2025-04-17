import 'package:backend/config/otp/otp_sender.dart';
import 'package:backend/config/otp/otp_service.dart';
import 'package:dio/dio.dart';
import 'package:redis/redis.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class OtpConfiguration {
  @Bean()
  OtpService otpService(Command redis, OtpSender otpSender) {
    return OtpService(redis: redis, sender: otpSender);
  }

  @Bean()
  OtpSender otpSender(Dio dio, ApplicationSettings settings) {
    return EmailOtpSender(
        title: 'Flotterando App código',
        fromEmail: 'app@flutterando.com.br',
        fromName: 'Flotterando App',
        settings: settings,
        dio: dio);
  }
}
