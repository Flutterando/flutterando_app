import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';

import '../../design_system/widgets/appbar_widget.dart';

import '../../design_system/widgets/button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(onNotification: () {}),
      body: SafeArea(
        child: Column(
          spacing: 12.0,
          children: [
            const Text('Tela de login'),
            ButtonWidget.filledPrimary(
              onPressed: () {
                Routefly.push(routePaths.auth.recoverPassword.sendEmail);
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
          ],
        ),
      ),
    );
  }
}
