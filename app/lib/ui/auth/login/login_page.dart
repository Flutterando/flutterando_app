import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../app_widget.dart';

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
            ElevatedButton(
              onPressed: () {
                Routefly.push(routePaths.auth.recoverPassword.sendEmail);
              },
              child: Text('Recupear Senha'),
            ),
            ElevatedButton(
              onPressed: () {
                Routefly.push(routePaths.feed);
              },
              child: Text('Feed'),
            ),
            ElevatedButton(
              onPressed: () {
                Routefly.push(routePaths.auth.register.path);
              },
              child: Text('Cadastro'),
            ),
          ],
        ),
      ),
    );
  }
}
