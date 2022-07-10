import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ship_dashboard/app/modules/auth/domain/entities/tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/domain/params/login_credentials.dart';
import 'package:ship_dashboard/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:ship_dashboard/app/modules/auth/domain/usecases/login.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late Login usecase;
  late AuthRepository repository;

  setUp(() {
    repository = AuthRepositoryMock();
    usecase = LoginImpl(repository);
  });

  test('login success', () async {
    final credentials = LoginCredentials();
    credentials.setEmail('jacobaraujo7@gmail.com');
    credentials.setPassword('12345678');
    final tokenization = Tokenization(accessToken: '', expiresIn: 0, refreshToken: '');
    when(() => repository.loginWithEmailAndPassword('amFjb2JhcmF1am83QGdtYWlsLmNvbToxMjM0NTY3OA==')).thenAnswer((_) async => Right(tokenization));

    final result = await usecase(credentials).run();

    expect(result.isRight(), true);
  });
}
