import 'package:vaden/vaden.dart';

import 'migration/migration.dart';

@Component()
class AppWarmup implements ApplicationRunner {
  @override
  Future<void> run(VadenApplication app) async {
    Migration migration = app.injector.get<Migration>();
    migration.start();
  }
}

@Component()
class AppRunner implements CommandLineRunner {
  @override
  Future<void> run(List<String> args) async {}
}
