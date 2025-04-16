import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:routefly/routefly.dart';

import '../../../../app_widget.dart';
import '../../../../config/dependencies.dart';
import '../../../../domain/dto/recover_password_otp_dto.dart';
import '../../../../domain/dto/recover_password_send_email_dto.dart';
import '../../../design_system/constants/spaces.dart';
import '../../../design_system/theme/theme.dart';
import '../../../design_system/widgets/alert_widget.dart';
import '../../../design_system/widgets/button_widget.dart';
import '../../../design_system/widgets/otp_widget.dart';
import 'opt_viewmodel.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

const secondsDefault = 60;

class _OtpPageState extends State<OtpPage> {
  final viewmodel = injector.get<OptViewmodel>();

  final credentials = RecoverPasswordOtpDto();

  final otpCtrl = OtpFieldController();
  Timer? _timer;
  int _secondsRemaining = secondsDefault;
  bool _canResend = false;
  bool _invalidCode = false;
  bool isButtonEnabled = false;

  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _startTimer();

    userEmail = Routefly.query.arguments as String;
    credentials.setEmail(userEmail);

    viewmodel.confirmOtpPasswordCommand.addListener(listener);
  }

  void listener() {
    if (viewmodel.confirmOtpPasswordCommand.isSuccess) {
      setState(() {
        _invalidCode = false;
        isButtonEnabled = true;
      });

      Routefly.pop(context);
      Routefly.push(routePaths.auth.recoverPassword.confirmPassword);
      return;
    }
    if (viewmodel.confirmOtpPasswordCommand.isFailure) {
      AlertWidget.error(context, message: 'Por favor tente novamente');
      setState(() {
        _invalidCode = true;
        isButtonEnabled = false;
      });
      return;
    }
  }

  void _startTimer() {
    _secondsRemaining = secondsDefault;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
    setState(() {});
  }

  void _resendCode() {
    if (_canResend) {
      final dto = RecoverPasswordSendEmailDto(email: userEmail);
      viewmodel.requestToRecoverPasswordCommand.execute(dto);

      otpCtrl.clear();

      setState(() {
        _invalidCode = false;
        isButtonEnabled = false;
      });

      _startTimer();
    }
  }

  void _verifyCode(String code) {
    credentials.setCode(code);
    viewmodel.confirmOtpPasswordCommand.execute(credentials);
  }

  @override
  void dispose() {
    _timer?.cancel();
    viewmodel.confirmOtpPasswordCommand.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: InkWell(
          onTap: () => Routefly.pop(context),
          child: Icon(
            Iconsax.arrow_left_2,
            size: Spaces.xl,
            color: context.colors.whiteColor,
          ),
        ),
        title: Text(
          'Recuperar senha',
          style: context.text.bodyXL18Bold.copyWith(
            color: context.colors.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spaces.l),
        child: SingleChildScrollView(
          child: Column(
            spacing: Spaces.l,
            children: [
              Container(
                width: Spaces.xxxxl,
                height: Spaces.xxxxl,
                margin: const EdgeInsets.only(top: Spaces.xxxl),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Spaces.xxxxl),
                  border: Border.all(color: context.colors.errorLightColor),
                ),
                child: Icon(
                  Iconsax.security_safe,
                  color: context.colors.errorLightColor,
                  size: Spaces.xl,
                ),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  'Insira o código que recebeu no seu e-mail.',
                  textAlign: TextAlign.center,
                  style: context.text.bodyL16Bold.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.colors.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Spaces.xl),
                child: OtpWidget(
                  length: 4,
                  controller: otpCtrl,
                  hasError: _invalidCode,
                  errorMessage: 'Código inválido!',
                  onCompleted: _verifyCode,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Spaces.xs,
                children: [
                  Text(
                    'Não recebi o código! ',
                    style: context.text.bodyM14Bold.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (!_canResend) ...[
                    Text(
                      'Reenviar em $_secondsRemaining\s',
                      style: context.text.bodyM14Bold.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Icon(Iconsax.refresh, size: Spaces.l),
                  ],
                  if (_canResend)
                    ValueListenableBuilder(
                      valueListenable:
                          viewmodel.requestToRecoverPasswordCommand,
                      builder: (context, _, _) {
                        final isRunning =
                            viewmodel.requestToRecoverPasswordCommand.isRunning;

                        return InkWell(
                          onTap: isRunning ? null : _resendCode,
                          child: Row(
                            spacing: Spaces.s,
                            children: [
                              Text(
                                'Reenviar',
                                style: context.text.bodyM14Bold.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const Icon(Iconsax.refresh, size: Spaces.l),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: Spaces.xxxl),
                width: 250,
                child: ValueListenableBuilder(
                  valueListenable: viewmodel.confirmOtpPasswordCommand,
                  builder: (context, _, _) {
                    return ButtonWidget.filledPrimary(
                      onPressed: () {
                        Routefly.push(
                          routePaths.auth.recoverPassword.confirmPassword,
                        );
                      },
                      text: 'Verificar código',
                      disabled:
                          !isButtonEnabled ||
                          viewmodel.confirmOtpPasswordCommand.isRunning,
                      padding: const EdgeInsets.symmetric(
                        vertical: Spaces.xl - Spaces.xs,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
