import 'package:fpdart/fpdart.dart';

import '../entities/tokenization.dart';
import '../exceptions/exceptions.dart';
import '../repositories/secure_storage_repository.dart';

abstract class GetTokenization {
  TaskEither<AuthException, Tokenization> call();
}

class GetTokenizationImpl implements GetTokenization {
  final SecureStorageRepository repository;

  GetTokenizationImpl(this.repository);

  @override
  TaskEither<AuthException, Tokenization> call() {
    return TaskEither(() => repository.getToken());
  }
}
