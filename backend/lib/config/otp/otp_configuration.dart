import 'package:backend/config/email/email_service.dart';
import 'package:backend/config/otp/otp_sender.dart';
import 'package:backend/config/otp/otp_service.dart';
import 'package:redis/redis.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class OtpConfiguration {
  @Bean()
  OtpService otpService(Command redis, OtpSender otpSender) {
    return OtpService(redis: redis, sender: otpSender);
  }

  @Bean()
  OtpSender otpSender(EmailService emailService, ApplicationSettings settings) {
    return EmailOtpSender(
        title: 'Flotterando App código',
        settings: settings,
        emailService: emailService);
  }
}
