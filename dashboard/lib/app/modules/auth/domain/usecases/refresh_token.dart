import 'package:fpdart/fpdart.dart';

import '../entities/tokenization.dart';
import '../exceptions/exceptions.dart';
import '../repositories/auth_repository.dart';

abstract class RefreshToken {
  TaskEither<AuthException, Tokenization> call(Tokenization token);
}

class RefreshTokenImpl implements RefreshToken {
  final AuthRepository repository;

  RefreshTokenImpl(this.repository);

  @override
  TaskEither<AuthException, Tokenization> call(Tokenization token) {
    return _validateToken(token).bindFuture(repository.refreshToken);
  }

  Either<AuthException, String> _validateToken(Tokenization tokenization) {
    final refreshToken = tokenization.refreshToken;
    if (refreshToken.isEmpty) {
      return left(const AuthException('RefreshToken nào pode ser vazio'));
    }

    return right(refreshToken);
  }
}
