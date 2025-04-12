import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:routefly/routefly.dart';

import '../../../../app_widget.dart';
import '../../../design_system/constants/spaces.dart';
import '../../../design_system/theme/theme.dart';
import '../../../design_system/widgets/button_widget.dart';
import '../../../design_system/widgets/input_widget.dart';

class ConfirmPasswordPage extends StatefulWidget {
  const ConfirmPasswordPage({super.key});

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spaces.l),
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
                  'Informe o seu e-mail cadastrado, iremos te enviar um código de verificação!',
                  textAlign: TextAlign.center,
                  style: context.text.bodyL16Bold.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.colors.whiteColor,
                  ),
                ),
              ),
              const InputWidget(label: 'Senha', hintText: 'Informe sua senha'),
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
              Container(
                margin: const EdgeInsets.only(top: Spaces.xxxl),
                width: 250,
                child: ButtonWidget.filledPrimary(
                  onPressed: () {
                    Routefly.push(
                      routePaths.auth.recoverPassword.feedbackSuccess,
                    );
                  },
                  text: 'Verificar código',
                  padding: const EdgeInsets.symmetric(
                    vertical: Spaces.xl - Spaces.xs,
                  ),
                ),
              ),
            ],
          ),
        ),
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
