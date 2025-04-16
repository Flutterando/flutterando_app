import 'package:dio/dio.dart' as client;
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../domain/services/send_email_service.dart';

@Service()
class SendEmailServiceImpl implements SendEmailService {
  final ApplicationSettings settings;
  final client.Dio dio;

  SendEmailServiceImpl(this.dio, this.settings);

  @override
  AsyncResult<Unit> sendEmail(Email email) async {
    Map<String, dynamic> data = {
      'personalizations': [
        {
          'to': [
            {'email': email.email, 'name': email.title}
          ],
          'subject': email.title
        }
      ],
      'content': [
        {'type': 'text/plain', 'value': email.content}
      ],
      'from': {'email': 'app@flutterando.com.br', 'name': 'App Flutterando'}
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
