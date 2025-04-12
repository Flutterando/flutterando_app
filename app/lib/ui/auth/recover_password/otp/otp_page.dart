import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:routefly/routefly.dart';

import '../../../../app_widget.dart';
import '../../../design_system/constants/spaces.dart';
import '../../../design_system/theme/theme.dart';
import '../../../design_system/widgets/button_widget.dart';
import '../../../design_system/widgets/input_widget.dart';
import '../../../design_system/widgets/otp_widget.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Icon(
          Iconsax.arrow_left_2,
          size: Spaces.xl,
          color: context.colors.whiteColor,
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
                child: OtpWidget(length: 4, onCompleted: (_) {}),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Spaces.xs,
                children: [
                  Text(
                    'Não recebi o código! Reenviar em',
                    style: context.text.bodyM14Bold.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '59s',
                    style: context.text.bodyM14Bold.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Icon(Iconsax.refresh, size: Spaces.l),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: Spaces.xxxl),
                width: 250,
                child: ButtonWidget.filledPrimary(
                  onPressed: () {
                    Routefly.push(
                      routePaths.auth.recoverPassword.confirmPassword,
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
