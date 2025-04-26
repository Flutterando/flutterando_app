// File: update_user_usecase_test.dart

import 'package:backend/src/domain/dto/user/user_dto.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/repositories/user_repository.dart';
import 'package:backend/src/domain/usecases/user/update_user_usecase.dart';
import 'package:backend/src/domain/enums/roles_user_enum.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class MockUserRepository extends Mock implements UserRepository {}

class FakeUserDTO extends Fake implements UserDTO {}

void main() {
  late MockUserRepository mockRepository;
  late UpdateUser updateUser;

  setUpAll(() {
    registerFallbackValue(FakeUserDTO());
  });

  setUp(() {
    mockRepository = MockUserRepository();
    updateUser = UpdateUser(mockRepository);
  });

  final user = User(
    id: 1,
    firstName: 'John',
    lastName: 'Doe',
    username: 'john@example.com',
    password: '123456',
    roles: ['admin'],
  );

  final updatedDto = UserDTO(
    id: 1,
    firstName: 'Johnny',
    lastName: 'Doe',
    email: 'johnny@example.com',
    password: 'abcdef',
    roles: [RolesUser.creator],
  );

  test('should return Failure when both dto.id and user are null', () async {
    final result = await updateUser.call(dto: UserDTO());

    expect(result.isError(), isTrue);
    expect(result.exceptionOrNull()?.toString(), contains('Unidentified user'));
  });

  test('should update user directly when user instance is provided', () async {
    when(() => mockRepository.updateUser(any()))
        .thenAnswer((_) async => Success(user));

    final result = await updateUser.call(dto: updatedDto, user: user);

    expect(result.isSuccess(), isTrue);
    verify(() => mockRepository.updateUser(any())).called(1);
  });

  test('should fetch user by id and then update', () async {
    when(() => mockRepository.getUsers(id: 1))
        .thenAnswer((_) async => Success([user]));

    when(() => mockRepository.updateUser(any()))
        .thenAnswer((_) async => Success(user));

    final result = await updateUser.call(dto: updatedDto);

    expect(result.isSuccess(), isTrue);
    verify(() => mockRepository.getUsers(id: 1)).called(1);
    verify(() => mockRepository.updateUser(any())).called(1);
  });

  test('should only update changed fields in DTO', () async {
    final minimalChangeDto = UserDTO(
      id: 1,
      firstName: 'John', // same
      lastName: 'Doe', // same
      email: 'john@example.com', // same
      password: '123456', // same
      roles: [RolesUser.admin], // same
    );

    when(() => mockRepository.updateUser(any()))
        .thenAnswer((_) async => Success(user));
    when(() => mockRepository.getUsers(id: 1))
        .thenAnswer((_) async => Success([user]));

    final result = await updateUser.call(dto: minimalChangeDto);

    expect(result.isSuccess(), isTrue);
    verify(() => mockRepository.updateUser(
          any(that: predicate<UserDTO>((dto) {
            return dto.firstName == null &&
                dto.lastName == null &&
                dto.email == null &&
                dto.password == null &&
                dto.roles == null;
          })),
        )).called(1);
  });

  test('should detect roles change and include in update', () async {
    final rolesChangeDto = UserDTO(
      id: 1,
      roles: [RolesUser.creator],
    );

    when(() => mockRepository.updateUser(any()))
        .thenAnswer((_) async => Success(user));
    when(() => mockRepository.getUsers(id: 1))
        .thenAnswer((_) async => Success([user]));

    final result = await updateUser.call(dto: rolesChangeDto);

    expect(result.isSuccess(), isTrue);
    verify(() => mockRepository.updateUser(
          any(that: predicate<UserDTO>((dto) {
            return dto.roles != null && dto.roles!.contains(RolesUser.creator);
          })),
        )).called(1);
  });
}
