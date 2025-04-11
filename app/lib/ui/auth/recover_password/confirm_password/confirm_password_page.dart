import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../../app_widget.dart';

class ConfirmPasswordPage extends StatefulWidget {
  const ConfirmPasswordPage({super.key});

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 12.0,
          children: [
            const Text('Tela de confirmar senha'),
            ElevatedButton(
              onPressed: () {
                Routefly.push(routePaths.auth.recoverPassword.feedbackSuccess);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
