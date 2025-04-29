import 'package:vaden/vaden.dart';

import 'migration/migration.dart';

@Component(true)
class AppWarmup implements ApplicationRunner {
  @override
  Future<void> run(VadenApplication app) async {
    Migration migration = app.injector.get<Migration>();
    migration.start();
  }
}

@Component(true)
class AppRunner implements CommandLineRunner {
  @override
  Future<void> run(List<String> args) async {}
}
