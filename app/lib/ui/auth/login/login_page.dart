import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';

import '../../design_system/widgets/alert_widget.dart';
import '../../design_system/widgets/appbar_widget.dart';

import '../../design_system/widgets/button_widget.dart';
import '../../design_system/widgets/otp_widget.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          spacing: 12.0,
          children: [
            const Text('Tela de login'),
            ButtonWidget.filledPrimary(
              onPressed: () {
                if(context.mounted) {
                  AlertWidget.success(context, message: 'Você foi cadastrado com sucesso!');
                }
//                Routefly.push(routePaths.auth.recoverPassword.sendEmail);
              },
              text: 'Recupear Senha',
            ),
            ButtonWidget.filledSecondary(
              onPressed: () {
                Routefly.push(routePaths.feed);
              },
              text: 'Feed',
            ),
            ButtonWidget.outlinePrimary(
              onPressed: () {
                Routefly.push(routePaths.auth.register.path);
              },
              text: 'Cadastro',
            ),
            OtpWidget(
              length: 4,
              controller: otpController,
              onCompleted: (value) => print(value),
              errorMessage: 'Código inválido!',
              hasError: true,
            )
          ],
        ),
      ),
    );
  }
}
