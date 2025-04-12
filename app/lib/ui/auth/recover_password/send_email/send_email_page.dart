import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../../app_widget.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 12.0,
          children: [
            const Text('Tela de envio de email para recuperar senha'),
            ElevatedButton(
              onPressed: () {
                Routefly.push(routePaths.auth.recoverPassword.otp);
              },
              child: const Text('Confirmar codigo otp'),
            ),
          ],
        ),
      ),
    );
  }
}
