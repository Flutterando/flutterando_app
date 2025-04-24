import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:routefly/routefly.dart';

import '../design_system/constants/spaces.dart';
import '../design_system/theme/theme.dart';
import '../design_system/widgets/button_widget.dart';

class FeedbackSuccessPage extends StatefulWidget {
  const FeedbackSuccessPage({super.key});

  @override
  State<FeedbackSuccessPage> createState() => _FeedbackSuccessPageState();
}

class _FeedbackSuccessPageState extends State<FeedbackSuccessPage> {
  late final FeedbackSuccessArgument arguments;

  @override
  void initState() {
    super.initState();
    assert(
    Routefly.query.arguments is FeedbackSuccessArgument,
    'FeedbackSuccessPage espera um argumento do tipo FeedbackSuccessArgument via Routefly.query.arguments, mas recebeu: ${Routefly.query.arguments.runtimeType}',
    );

    arguments = Routefly.query.arguments as FeedbackSuccessArgument;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: Spaces.l,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Spaces.xxxxl,
              height: Spaces.xxxxl,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Spaces.xxxxl),
                border: Border.all(color: context.colors.successLightColor),
              ),
              child: Icon(
                Iconsax.tick_circle,
                color: context.colors.successLightColor,
                size: Spaces.xl,
              ),
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Cadastro realizado com sucesso!',
                textAlign: TextAlign.center,
                style: context.text.bodyXL18Bold.copyWith(
                  color: context.colors.whiteColor,
                ),
              ),
            ),
            Text(
              'Seja bem-vindo à Flutterando',
              style: context.text.bodyL16Bold.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              width: 250,
              margin: const EdgeInsets.only(top: Spaces.l),
              child: ButtonWidget.filledPrimary(
                onPressed: arguments.onConfirm,
                text: 'Começar',
                padding: const EdgeInsets.symmetric(
                  vertical: Spaces.xl - Spaces.xs,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackSuccessArgument {
  final VoidCallback onConfirm;

  FeedbackSuccessArgument({required this.onConfirm});
}
