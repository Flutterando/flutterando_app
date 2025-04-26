import 'package:backend/config/email/email_entity.dart';
import 'package:backend/config/email/email_service.dart';
import 'package:backend/src/domain/dto/user/user_dto.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

abstract interface class OtpSender {
  AsyncResult<Unit> sendOtp({required UserDTO dto, required String code});
}

class EmailOtpSender implements OtpSender {
  final String title;
  final ApplicationSettings settings;
  final EmailService emailService;

  EmailOtpSender({
    required this.title,
    required this.settings,
    required this.emailService,
  });

  @override
  AsyncResult<Unit> sendOtp(
      {required UserDTO dto, required String code}) async {
    final Email email = Email.text(
      addressee: dto.email!,
      recipientName: '${dto.firstName} ${dto.lastName}',
      title: title,
      emailBody: 'Seu codigo é $code',
    );

    return emailService.send(email);
  }
}
