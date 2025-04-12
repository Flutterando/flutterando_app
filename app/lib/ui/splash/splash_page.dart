import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../app_widget.dart';
import '../design_system/theme/theme.dart';
import '../design_system/widgets/svg_image_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animeCtrl;
  Animation<Color?>? colorAnimation;

  @override
  void initState() {
    super.initState();

    animeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      colorAnimation = ColorTween(
        begin: context.colors.primaryColor,
        end: context.colors.backgroundColor,
      ).animate(
        CurvedAnimation(
          parent: animeCtrl,
          curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
        ),
      );

      animeCtrl.forward();
      Future.delayed(
        const Duration(seconds: 2),
      ).then((_) => Routefly.navigate(routePaths.auth.login));
    });
  }

  @override
  void dispose() {
    animeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animeCtrl,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: colorAnimation?.value ?? Colors.black,
          body: Center(child: SvgImage.logoWhite.image()),
        );
      },
    );
  }
}
