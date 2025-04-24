import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucid_validation/lucid_validation.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';
import '../../../config/dependencies.dart';
import '../../../domain/dto/register_dto.dart';
import '../../../domain/validators/register_validation.dart';
import '../../design_system/constants/spaces.dart';
import '../../design_system/theme/theme.dart';
import '../../design_system/widgets/button_widget.dart';
import '../../design_system/widgets/input_widget.dart';
import '../../design_system/widgets/svg_image_widget.dart';
import '../../generic_pages/feedback_error_page.dart';
import '../../generic_pages/feedback_success_page.dart';
import '../security/otp/otp_page.dart';
import 'register_viewmodel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final validator = RegisterValidation();
  final credentials = RegisterDto();
  final viewmodel = injector.get<RegisterViewmodel>();
  final isButtonEnabled = ValueNotifier(true);
  final exceptionsPassword = ValueNotifier<List<String>>([]);

  @override
  void initState() {
    super.initState();
    _updateButtonState();
    _checkPasswordValidation();
    viewmodel.registerCommand.addListener(listener);
  }

  void listener() {
    if (viewmodel.registerCommand.isFailure && context.mounted) {
      Routefly.push(
        routePaths.genericPages.feedbackError,
        arguments: FeedbackErrorArgument(onRetry: () => Routefly.pop(context)),
      );
      return;
    }
    if (viewmodel.registerCommand.isSuccess && context.mounted) {
      Routefly.pop(context);

      void goToSuccessPage() => Routefly.push(
        routePaths.genericPages.feedbackSuccess,
        arguments: FeedbackSuccessArgument(
          onConfirm: () => Routefly.push(routePaths.post.feed),
        ),
      );

      Routefly.push(
        routePaths.auth.security.otp,
        arguments: OptArguments(
          titlePage: 'Confirmar email',
          email: credentials.email,
          onSuccess: goToSuccessPage,
        ),
      );

      return;
    }
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

  void _submit() {
    if (formKey.currentState!.validate() && exceptionsPassword.value.isEmpty) {
      viewmodel.registerCommand.execute(credentials);
    }
  }

  @override
  void dispose() {
    viewmodel.registerCommand.removeListener(listener);
    super.dispose();
  }

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
                child: Form(
                  key: formKey,
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
                      InputWidget(
                        label: 'Nome',
                        onChanged: (value) {
                          credentials.setFirstName(value);
                          _updateButtonState();
                        },
                        validator: validator.byField(credentials, 'firstName'),
                        hintText: 'Informe seu nome',
                      ),
                      InputWidget(
                        label: 'Sobrenome',
                        onChanged: (value) {
                          credentials.setLastName(value);
                          _updateButtonState();
                        },
                        validator: validator.byField(credentials, 'lastName'),
                        hintText: 'Informe seu sobrenome',
                      ),
                      InputWidget(
                        label: 'E-mail',
                        onChanged: (value) {
                          credentials.setEmail(value);
                          _updateButtonState();
                        },
                        validator: validator.byField(credentials, 'email'),
                        hintText: 'Informe seu email',
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
                          return PasswordRequirements(
                            errors: exceptionsPassword,
                          );
                        },
                      ),
                      InputWidget(
                        label: 'Repetir senha',
                        obscureText: true,
                        onChanged: (value) {
                          credentials.setConfirmPassword(value);
                          _updateButtonState();
                        },
                        validator: validator.byField(
                          credentials,
                          'confirmPassword',
                        ),
                        hintText: 'Repita a sua senha',
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
                                recognizer:
                                    TapGestureRecognizer()..onTap = () {},
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
                        child: ListenableBuilder(
                          listenable: Listenable.merge([
                            isButtonEnabled,
                            viewmodel.registerCommand,
                          ]),
                          builder: (context, _) {
                            return ButtonWidget.filledPrimary(
                              onPressed: _submit,
                              text: 'Entrar',
                              disabled:
                                  isButtonEnabled.value ||
                                  viewmodel.registerCommand.isRunning,
                              padding: const EdgeInsets.symmetric(
                                vertical: Spaces.xl - Spaces.xs,
                              ),
                            );
                          },
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
          ),
        ],
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
