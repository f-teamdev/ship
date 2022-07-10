import 'package:fpdart/fpdart.dart';
import 'package:ship_dashboard/app/modules/auth/domain/entities/tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/domain/exceptions/exceptions.dart';
import 'package:ship_dashboard/app/modules/auth/domain/repositories/secure_storage_repository.dart';

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
