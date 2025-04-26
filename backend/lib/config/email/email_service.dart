import 'package:backend/config/email/email_entity.dart';
import 'package:dio/dio.dart' as client;
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

class EmailService {
  final String fromEmail;
  final String fromName;
  final ApplicationSettings settings;
  final client.Dio dio;
  EmailService({
    required this.fromEmail,
    required this.fromName,
    required this.settings,
    required this.dio,
  });

  AsyncResult<Unit> send(Email email) async {
    try {
      final response = await dio.post(
        'https://api.sendgrid.com/v3/mail/send',
        data: email.toMap(fromEmail: fromEmail, fromName: fromName),
        options: client.Options(
          headers: {
            'Authorization': 'Bearer ${settings['env']['emailToken']}',
            'Content-Type': 'application/json',
          },
          responseType: client.ResponseType.json,
          receiveTimeout: const Duration(seconds: 5),
          sendTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.statusCode == 202) {
        return Success(unit);
      }
      return Failure(Exception('Email not send'));
    } on client.DioException catch (e) {
      return Failure(e);
    }
  }
}
