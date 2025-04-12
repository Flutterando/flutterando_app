import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:routefly/routefly.dart';

import '../../../../app_widget.dart';
import '../../../design_system/constants/spaces.dart';
import '../../../design_system/theme/theme.dart';
import '../../../design_system/widgets/button_widget.dart';
import '../../../design_system/widgets/input_widget.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
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
                  Iconsax.sms,
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
              InputWidget(label: 'E-mail', hintText: 'Informe seu email'),
              Container(
                margin: const EdgeInsets.only(top: Spaces.xxxl),
                width: 250,
                child: ButtonWidget.filledPrimary(
                  onPressed: () {
                    Routefly.push(routePaths.auth.recoverPassword.otp);
                  },
                  text: 'Enviar código',
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
