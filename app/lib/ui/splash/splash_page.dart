import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../app_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
    ).then((_) => Routefly.navigate(routePaths.auth.login));
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
