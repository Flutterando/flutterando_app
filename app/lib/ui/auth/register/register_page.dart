import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:routefly/routefly.dart';

import '../../design_system/constants/spaces.dart';
import '../../design_system/theme/theme.dart';
import '../../design_system/widgets/button_widget.dart';
import '../../design_system/widgets/input_widget.dart';
import '../../design_system/widgets/svg_image_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: SvgImage.bgLogo.image(),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spaces.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    const InputWidget(
                      label: 'Nome',
                      hintText: 'Informe seu nome',
                    ),
                    const InputWidget(
                      label: 'Sobrenome',
                      hintText: 'Informe seu sobrenome',
                    ),
                    const InputWidget(
                      label: 'E-mail',
                      hintText: 'Informe seu email',
                    ),
                    const InputWidget(
                      label: 'Senha',
                      hintText: 'Informe sua senha',
                    ),
                    const PasswordRequirements(
                      errors: [
                        PasswordRequirement.minLength,
                        PasswordRequirement.upperCase,
                        PasswordRequirement.lowerCase,
                        PasswordRequirement.number,
                        PasswordRequirement.specialChar,
                      ],
                    ),
                    const InputWidget(
                      label: 'Repetir senha',
                      hintText: 'Repita a sua senha',
                    ),
                    Row(
                      spacing: Spaces.s,
                      children: [
                        Icon(
                          Iconsax.info_circle,
                          size: Spaces.l,
                          color: context.colors.errorLightColor,
                        ),
                        const Text(
                          'As senhas devem ser iguais',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
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
                                  'Ao tocar no botão “Cadastrar” você concorda com os ',
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
                        horizontal: Spaces.xxxxxl,
                        vertical: Spaces.xxl,
                      ),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: 'Já tenho uma conta? ',
                          children: [
                            TextSpan(
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () => Routefly.pop(context),
                              text: 'Entrar',
                              style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum PasswordRequirement {
  minLength,
  upperCase,
  lowerCase,
  number,
  specialChar,
}

class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key, required this.errors});

  final List<PasswordRequirement> errors;

  @override
  Widget build(BuildContext context) {
    final Map<PasswordRequirement, String> requirementsMap = {
      PasswordRequirement.minLength: 'Pelo menos 8 caracteres',
      PasswordRequirement.upperCase: 'Pelo menos uma letra maiúscula',
      PasswordRequirement.lowerCase: 'Pelo menos uma letra minúscula',
      PasswordRequirement.number: 'Pelo menos um número',
      PasswordRequirement.specialChar:
          'Pelo menos um caractere especial (@\$!%*#?&)',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          requirementsMap.entries.map((entry) {
            var colorIcon = context.colors.successLightColor;

            if (errors.contains(entry.key)) {
              colorIcon = context.colors.errorLightColor;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: Spaces.xs),
              child: Row(
                spacing: Spaces.s,
                children: [
                  Icon(Iconsax.info_circle, size: Spaces.l, color: colorIcon),
                  Text(entry.value, style: context.text.bodyS12Bold),
                ],
              ),
            );
          }).toList(),
    );
  }
}
