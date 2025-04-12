import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';
import '../../../domain/dto/credentials_login_dto.dart';
import '../../../domain/validators/credentials_login_validator.dart';
import '../../../main.dart';
import '../../design_system/constants/spaces.dart';
import '../../design_system/theme/theme.dart';

import '../../design_system/widgets/button_widget.dart';
import '../../design_system/widgets/input_widget.dart';
import '../../design_system/widgets/svg_image_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final validator = CredentialsLoginValidator();
  final credentials =
      isProduction //
          ? CredentialsLoginDto()
          : CredentialsLoginDto.withTestUser();

  final isButtonEnabled = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _updateButtonState();
  }

  void _updateButtonState() {
    final emailValid =
        validator.byField(credentials, 'email')(credentials.email) == null;
    final passwordValid =
        validator.byField(credentials, 'password')(credentials.password) ==
        null;

    isButtonEnabled.value = !(emailValid && passwordValid);
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      /// request to API
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(bottom: 0, right: 0, child: SvgImage.bgLogo.image()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spaces.xl),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Spaces.xl,
                children: [
                  Text(
                    'Bem-vindo de volta à',
                    style: context.text.bodyL16Bold.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.colors.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SvgImage.logoLarge.image(),
                  Text(
                    'A maior comunidade de Flutter\n da América latina',
                    style: context.text.bodyL16Bold.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.colors.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  InputWidget(
                    label: 'E-mail',
                    onChanged: (value) {
                      credentials.setEmail(value);
                      _updateButtonState();
                    },
                    validator: validator.byField(credentials, 'email'),
                    initialValue: credentials.email,
                    hintText: 'Informe seu email',
                  ),
                  InputWidget(
                    label: 'Senha',
                    onChanged: (value) {
                      credentials.setPassword(value);
                      _updateButtonState();
                    },
                    validator: validator.byField(credentials, 'password'),
                    initialValue: credentials.password,
                    hintText: 'Informe sua senha',
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Transform.translate(
                      offset: const Offset(0, -15),
                      child: InkWell(
                        onTap:
                            () => Routefly.push(
                              routePaths.auth.recoverPassword.sendEmail,
                            ),
                        child: Text(
                          'Forget password   ',
                          style: context.text.bodyL16Bold.copyWith(
                            color: context.colors.greyTwo,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spaces.xl,
                      vertical: Spaces.l,
                    ),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Ao tocar no botão “Entrar” você concorda com os ',
                            style: context.text.bodyM14Bold.copyWith(
                              color: context.colors.greyThree,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            text: 'termos de uso',
                            style: context.text.bodyM14Bold.copyWith(
                              color: context.colors.whiteColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spaces.xxxxxl,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: isButtonEnabled,
                      builder: (context, isButtonEnabled, _) {
                        return ButtonWidget.filledPrimary(
                          onPressed: _onSubmit,
                          text: 'Entrar',
                          disabled: isButtonEnabled,
                          padding: const EdgeInsets.symmetric(
                            vertical: Spaces.xl - Spaces.xs,
                          ),
                        );
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spaces.xl,
                      vertical: Spaces.l,
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Não tenho uma conta! ',
                            style: context.text.bodyM14Bold.copyWith(
                              color: context.colors.greyThree,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap =
                                      () => Routefly.push(
                                        routePaths.auth.register.path,
                                      ),
                            text: 'Cadastrar',
                            style: context.text.bodyM14Bold.copyWith(
                              color: context.colors.whiteColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
