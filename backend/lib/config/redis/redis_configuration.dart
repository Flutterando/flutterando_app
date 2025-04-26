import 'package:redis/redis.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class RedisConfiguration {
  @Bean()
  Future<Command> redisCommand(ApplicationSettings settings) {
    final host = settings['redis']['host'];
    final port = settings['redis']['port'];
    final connection = RedisConnection();
    return connection.connect(host, port);
  }
}
