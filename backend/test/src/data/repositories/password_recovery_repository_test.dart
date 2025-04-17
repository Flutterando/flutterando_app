import 'package:backend/src/data/repositories/password_recovery_repository.dart';
import 'package:backend/src/domain/repositories/password_recovery_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:redis/redis.dart';

class MockRedisCommand extends Mock implements Command {}

void main() {
  late MockRedisCommand mockRedis;
  late PasswordRecoveryRepository repository;

  const testUsername = 'john_doe';
  const testCode = '1234';
  const redisKey = 'PasswordRecover:$testUsername';

  setUp(() {
    mockRedis = MockRedisCommand();
    repository = PasswordRecoveryRepositoryImpl(mockRedis);
  });

  group('PasswordRecoveryRepositoryImpl', () {
    group('getCode', () {
      test('should return Success when code is found in Redis', () async {
        when(() => mockRedis.send_object(['GET', redisKey]))
            .thenAnswer((_) async => testCode);

        final result = await repository.getCode(testUsername);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), equals(testCode));
      });

      test('should return Failure when Redis returns null', () async {
        when(() => mockRedis.send_object(['GET', redisKey]))
            .thenAnswer((_) async => null);

        final ResultDart<String, Exception> result =
            await repository.getCode(testUsername);

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<Exception>());
      });

      test('should return Failure on Redis exception', () async {
        when(() => mockRedis.send_object(['GET', redisKey]))
            .thenThrow(Exception('Redis error'));

        final ResultDart<String, Exception> result =
            await repository.getCode(testUsername);

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<Exception>());
      });
    });

    group('setCode', () {
      test('should return Success when code is successfully set and expired',
          () async {
        when(() => mockRedis.send_object(['SET', redisKey, testCode]))
            .thenAnswer((_) async => 'OK');
        when(() => mockRedis.send_object(['EXPIRE', redisKey, '240']))
            .thenAnswer((_) async => 1);

        final ResultDart<String, Exception> result =
            await repository.setCode(username: testUsername, code: testCode);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), equals(testCode));
      });

      test('should return Failure on Redis set error', () async {
        when(() => mockRedis.send_object(any()))
            .thenThrow(Exception('Redis error'));

        final ResultDart<String, Exception> result =
            await repository.setCode(username: testUsername, code: testCode);

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<Exception>());
      });
    });

    group('expireTime', () {
      test('should return Success with TTL when TTL is valid', () async {
        when(() => mockRedis.send_object(['TTL', redisKey]))
            .thenAnswer((_) async => 180);

        final ResultDart<int, Exception> result =
            await repository.expireTime(testUsername);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), equals(180));
      });

      test('should return Success with 0 when TTL is negative', () async {
        when(() => mockRedis.send_object(['TTL', redisKey]))
            .thenAnswer((_) async => -1);

        final ResultDart<int, Exception> result =
            await repository.expireTime(testUsername);

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull(), equals(0));
      });

      test('should return Failure on Redis exception', () async {
        when(() => mockRedis.send_object(['TTL', redisKey]))
            .thenThrow(Exception('Redis error'));

        final ResultDart<int, Exception> result =
            await repository.expireTime(testUsername);

        expect(result.isError(), isTrue);
        expect(result.exceptionOrNull(), isA<Exception>());
      });
    });
  });
}
