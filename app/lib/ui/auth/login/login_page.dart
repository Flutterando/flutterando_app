import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';
import '../../design_system/widgets/button_widget.dart';
import '../../design_system/widgets/snack_bar_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 12.0,
          children: [
            Text('Tela de login'),
            ButtonWidget.filledPrimary(
              onPressed: () {
                if(context.mounted) {
                  SnackBarWidget.error(context, 'Você foi cadastrado com sucesso!');
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
          ],
        ),
      ),
    );
  }
}
