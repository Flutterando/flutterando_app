import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../../app_widget.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 12.0,
          children: [
            const Text('Tela de confirmação do codigo otp'),
            ElevatedButton(
              onPressed: () {
                Routefly.push(routePaths.auth.recoverPassword.confirmPassword);
              },
              child: const Text('Confirmar senha'),
            ),
          ],
        ),
      ),
    );
  }
}
