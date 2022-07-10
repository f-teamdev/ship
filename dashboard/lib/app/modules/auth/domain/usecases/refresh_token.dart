import 'package:fpdart/fpdart.dart';
import 'package:ship_dashboard/app/modules/auth/domain/entities/tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/domain/exceptions/exceptions.dart';
import 'package:ship_dashboard/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class RefreshToken {
  TaskEither<AuthException, Tokenization> call(String refreshToken);
}

class RefreshTokenImpl implements RefreshToken {
  final AuthRepository repository;

  RefreshTokenImpl(this.repository);

  @override
  TaskEither<AuthException, Tokenization> call(String refreshToken) {
    return _validateToken(refreshToken).bindFuture(repository.refreshToken);
  }

  Either<AuthException, String> _validateToken(String refreshToken) {
    if (refreshToken.isEmpty) {
      return left(AuthException('RefreshToken nào pode ser vazio'));
    }

    return right(refreshToken);
  }
}
