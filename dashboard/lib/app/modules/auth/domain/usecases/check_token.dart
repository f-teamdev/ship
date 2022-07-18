import 'package:fpdart/fpdart.dart';

import '../entities/tokenization.dart';
import '../exceptions/exceptions.dart';
import '../repositories/auth_repository.dart';

abstract class CheckToken {
  TaskEither<AuthException, Tokenization> call(Tokenization accessToken);
}

class CheckTokenImpl implements CheckToken {
  final AuthRepository repository;

  CheckTokenImpl(this.repository);

  @override
  TaskEither<AuthException, Tokenization> call(Tokenization token) {
    return TaskEither(() => repository.checkToken(token.accessToken)).map((r) => token);
  }
}
