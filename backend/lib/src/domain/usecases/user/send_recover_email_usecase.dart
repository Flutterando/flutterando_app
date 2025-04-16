import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../../entities/user.dart';
import '../../repositories/password_recover_repository.dart';
import '../../services/password_code_generator_service.dart';
import '../../services/send_email_service.dart';

@Component()
class SendRecoverPasswordEmail {
  final UserRepository _userRepository;
  final PasswordRecoverRepository _passwordRecoverRepository;
  final PasswordCodeGeneratorService _passwordCodeGeneratorService;
  final SendEmailService _emailService;

  SendRecoverPasswordEmail(
    this._userRepository,
    this._passwordRecoverRepository,
    this._passwordCodeGeneratorService,
    this._emailService,
  );

  AsyncResult<Unit> call(String email) async {
    return _validationRequest(email) //
        .flatMap(_userRepository.getUser)
        .flatMap(_setCode)
        .flatMap(_sendEmail);
  }

  AsyncResult<String> _validationRequest(String email) async {
    return _passwordRecoverRepository //
        .expireTime(email)
        .flatMap((time) {
      if (time > 120) {
        return Failure(ResponseException.notAcceptable(
            'The request was sent to fewer than two ministers'));
      }
      return Success(email);
    });
  }

  AsyncResult<(String, User)> _setCode(User user) async {
    return _passwordCodeGeneratorService //
        .codeGenerator(4)
        .toAsyncResult()
        .flatMap((code) => _passwordRecoverRepository //
            .setCode(username: user.username, code: code)
            .flatMap((_) => Success((code, user))));
  }

  AsyncResult<Unit> _sendEmail((String, User) codeAndUser) async {
    final (code, user) = codeAndUser;
    final email = Email(
        email: user.username,
        name: '${user.firstName} ${user.lastName}',
        title: 'Recuperação de senha Flutter App',
        content: 'Seu codigo de recuperação é $code');

    return _emailService.sendEmail(email);
  }
}
