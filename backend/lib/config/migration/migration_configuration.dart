import 'package:backend/config/migration/migration.dart';
import 'package:postgres/postgres.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class MigrationConfiguration {
  @Bean()
  Future<Migration> start(Pool connection, ApplicationSettings settings) async {
    return Migration(
      connection: connection,
      migrationPath: settings['env']['migrationPath'],
    );
  }
}
