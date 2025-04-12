import 'package:routefly/routefly.dart';
import 'package:flutter/material.dart';
import 'app_widget.route.dart';
import 'ui/design_system/theme/dark_theme.dart';

part 'app_widget.g.dart';

@Main('lib/ui')
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: darkTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.auth.register.pages.feedbackError,
      ),
    );
  }
}
