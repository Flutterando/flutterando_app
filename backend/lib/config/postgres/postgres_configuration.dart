import 'package:postgres/postgres.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class PostgresConfiguration {
  @Bean()
  Pool connection(ApplicationSettings settings) {
    SslMode sslAdapter(String? ssl) {
      return switch (ssl) {
        'disable' => SslMode.disable,
        'require' => SslMode.require,
        'verifyFull' => SslMode.verifyFull,
        _ => SslMode.disable,
      };
    }

    final endpoint = Endpoint(
      host: settings['postgres']['host'],
      database: settings['postgres']['database'],
      port: settings['postgres']['port'],
      username: settings['postgres']['username'],
      password: settings['postgres']['password'],
    );

    final poolSettings = PoolSettings(
      maxConnectionCount: settings['postgres']['maxConnectionCount'],
      maxConnectionAge: Duration(hours: 1),
      maxSessionUse: Duration(minutes: 30),
      sslMode: sslAdapter(settings['postgres']['ssl']),
    );

    return Pool.withEndpoints([endpoint], settings: poolSettings);
  }
}
