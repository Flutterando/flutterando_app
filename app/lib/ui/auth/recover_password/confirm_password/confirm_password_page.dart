import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucid_validation/lucid_validation.dart';
import 'package:routefly/routefly.dart';

import '../../../../app_widget.dart';
import '../../../../domain/dto/recover_password_dto.dart';
import '../../../../domain/validators/recover_password_validation.dart';
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
  final formKey = GlobalKey<FormState>();
  final validator = RecoverPasswordValidation();
  final credentials = RecoverPasswordDto();

  final isButtonEnabled = ValueNotifier(true);
  final exceptionsPassword = ValueNotifier<List<String>>([]);

  @override
  void initState() {
    super.initState();
    _updateButtonState();
    _checkPasswordValidation();
  }

  void _updateButtonState() {
    final exceptions = validator.getExceptions(credentials);

    isButtonEnabled.value = exceptions.isNotEmpty;
  }

  void _checkPasswordValidation() {
    final exceptionsListPassword = validator.getExceptionsByKey(
      credentials,
      'password',
    );

    exceptionsPassword.value =
        exceptionsListPassword.map((e) => e.code).toList();
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
              InputWidget(
                label: 'Senha',
                obscureText: true,
                onChanged: (value) {
                  credentials.setPassword(value);
                  _updateButtonState();
                },
                validator: (value) {
                  _checkPasswordValidation();
                  _updateButtonState();

                  return null;
                },
                hintText: 'Informe sua senha',
              ),
              ValueListenableBuilder(
                valueListenable: exceptionsPassword,
                builder: (context, exceptionsPassword, _) {
                  return PasswordRequirements(errors: exceptionsPassword);
                },
              ),
              InputWidget(
                label: 'Repetir senha',
                obscureText: true,
                onChanged: (value) {
                  credentials.setConfirmPassword(value);
                  _updateButtonState();
                },
                validator: validator.byField(credentials, 'confirmPassword'),
                hintText: 'Repita a sua senha',
              ),
              Container(
                margin: const EdgeInsets.only(top: Spaces.xxxl),
                width: 250,
                child: ValueListenableBuilder(
                    valueListenable: isButtonEnabled,
                  builder: (context, isButtonEnabled, _) {
                    return ButtonWidget.filledPrimary(
                      onPressed: () {
                        Routefly.push(
                          routePaths.auth.recoverPassword.feedbackSuccess,
                        );
                      },
                      text: 'Verificar código',
                      disabled: isButtonEnabled,
                      padding: const EdgeInsets.symmetric(
                        vertical: Spaces.xl - Spaces.xs,
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key, required this.errors});

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> requirementsMap = {
      Language.code.minLength: 'Pelo menos 8 caracteres',
      Language.code.mustHaveUppercase: 'Pelo menos uma letra maiúscula',
      Language.code.mustHaveLowercase: 'Pelo menos uma letra minúscula',
      Language.code.mustHaveNumber: 'Pelo menos um número',
      Language.code.mustHaveSpecialCharacter:
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

