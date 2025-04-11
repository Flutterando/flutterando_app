import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'config/dependencies.dart';

var isProduction = true;

void main() {
  assert(() {
    isProduction = false;
    return true;
  }());

  WidgetsFlutterBinding.ensureInitialized();

  setupInjector();

  runApp(const AppWidget());
}

