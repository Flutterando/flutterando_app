import 'package:result_dart/result_dart.dart';

abstract interface class SendEmailService {
  AsyncResult<Unit> sendEmail(Email email);
}

class Email {
  final String email;
  final String name;
  final String title;
  final String content;
  Email({
    required this.email,
    required this.name,
    required this.title,
    required this.content,
  });
}
