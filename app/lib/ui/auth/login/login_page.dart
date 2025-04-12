import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';
import '../../design_system/constants/spaces.dart';
import '../../design_system/theme/theme.dart';

import '../../design_system/widgets/button_widget.dart';
import '../../design_system/widgets/input_widget.dart';
import '../../design_system/widgets/otp_widget.dart';
import '../../design_system/widgets/svg_image_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final otpController = OtpFieldController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      otpController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(bottom: 0, right: 0, child: SvgImage.bgLogo.image()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spaces.xl),
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
                const InputWidget(label: 'E-mail', hintText: 'Informe seu email'),
                const InputWidget(
                  label: 'Senha',
                  hintText: 'Informe sua senha',
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Forget password   ',
                      style: context.text.bodyL16Bold.copyWith(
                        color: context.colors.greyTwo,
                        height: -0.25,
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
                  child: ButtonWidget.filledPrimary(
                    onPressed: () {},
                    text: 'Entrar',
                    disabled: true,
                    padding: const EdgeInsets.symmetric(
                      vertical: Spaces.xl - Spaces.xs,
                    ),
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
        ],
      ),
    );
  }
}
