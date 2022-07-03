import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';
import 'package:backend/src/modules/user/domain/repositories/user_repository.dart';
import 'package:backend/src/modules/user/domain/usecases/create_user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late UserRepository repository;
  late CreateUser createUser;

  setUp(() {
    repository = UserRepositoryMock();
    createUser = CreateUserImp(repository);
  });

  test('create user', () async {
    final params = UserParameters(name: 'test ok', email: 'jacob@fteam.dev', role: UserRole.admin, password: 'J@c0bMour@');
    when(() => repository.createUser(params)).thenAnswer((_) async => Right(UserEntityMock()));

    final result = await createUser(params);
    expect(result.fold(id, id), isA<UserEntity>());
  });

  group('validations | ', () {
    test('Email not valid', () async {
      final params = UserParameters(name: 'test ok', email: 'jacob', role: UserRole.admin, password: 'J@c0bMour@');
      final result = await createUser(params);
      expect(result.fold(id, id), isA<UserCreationValidate>());
    });

    test('needs lastname', () async {
      final params = UserParameters(name: 'test', email: 'jacob@fteam.dev', role: UserRole.admin, password: 'J@c0bMour@');
      final result = await createUser(params);
      expect(result.fold(id, id), isA<UserCreationValidate>());
    });
  });
}
