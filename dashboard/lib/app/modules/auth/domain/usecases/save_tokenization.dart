import 'package:fpdart/fpdart.dart';

import '../entities/tokenization.dart';
import '../exceptions/exceptions.dart';
import '../repositories/secure_storage_repository.dart';

abstract class SaveTokenization {
  TaskEither<SecureStorageException, Unit> call(Tokenization tokenization);
}

class SaveTokenizationImpl implements SaveTokenization {
  final SecureStorageRepository repository;

  SaveTokenizationImpl(this.repository);

  @override
  TaskEither<SecureStorageException, Unit> call(Tokenization tokenization) {
    return TaskEither(() => repository.saveToken(tokenization));
  }
}
