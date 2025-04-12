import 'package:flutter/material.dart';
import 'package:lucid_validation/lucid_validation.dart';

import 'app_widget.dart';
import 'config/dependencies.dart';

var isProduction = true;

void main() {
  assert(() {
    isProduction = false;
    return true;
  }());

  WidgetsFlutterBinding.ensureInitialized();
  final culture = Culture('pt', 'BR');
  LucidValidation.global.culture = culture;

  setupInjector();

  runApp(const AppWidget());
}

