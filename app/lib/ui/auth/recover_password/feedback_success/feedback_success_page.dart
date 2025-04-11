import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../../app_widget.dart';

class FeedbackSuccessPage extends StatefulWidget {
  const FeedbackSuccessPage({super.key});

  @override
  State<FeedbackSuccessPage> createState() => _FeedbackSuccessPageState();
}

class _FeedbackSuccessPageState extends State<FeedbackSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 12.0,
          children: [
            const Text('Tela de feedback de sucesso'),
            ElevatedButton(
              onPressed: () {
                Routefly.push(routePaths.feed);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
