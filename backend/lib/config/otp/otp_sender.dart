import 'package:backend/src/domain/entities/user.dart';
import 'package:dio/dio.dart' as client;
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

abstract class OtpSender {
  AsyncResult<Unit> sendOtp({required User user, required String code});
}

class EmailOtpSender implements OtpSender {
  final String title;
  final String fromEmail;
  final String fromName;
  final ApplicationSettings settings;
  final client.Dio dio;

  EmailOtpSender({
    required this.title,
    required this.fromEmail,
    required this.fromName,
    required this.settings,
    required this.dio,
  });

  @override
  AsyncResult<Unit> sendOtp({required User user, required String code}) async {
    Map<String, dynamic> data = {
      'personalizations': [
        {
          'to': [
            {
              'email': user.username,
              'name': '${user.firstName} ${user.lastName}'
            }
          ],
          'subject': title
        }
      ],
      'content': [
        {'type': 'text/plain', 'value': 'Seu codigo é $code'}
      ],
      'from': {'email': fromEmail, 'name': fromName}
    };

    try {
      final response = await dio.post(
        'https://api.sendgrid.com/v3/mail/send',
        data: data,
        options: client.Options(
          headers: {
            'Authorization': 'Bearer ${settings['env']['emailToken']}',
            'Content-Type': 'application/json'
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
