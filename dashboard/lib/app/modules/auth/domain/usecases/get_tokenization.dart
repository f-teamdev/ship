import 'package:fpdart/fpdart.dart';
import 'package:ship_dashboard/app/modules/auth/domain/entities/tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/domain/exceptions/exceptions.dart';
import 'package:ship_dashboard/app/modules/auth/domain/repositories/secure_storage_repository.dart';

abstract class GetTokenization {
  TaskEither<SecureStorageException, Tokenization> call();
}

class GetTokenizationImpl implements GetTokenization {
  final SecureStorageRepository repository;

  GetTokenizationImpl(this.repository);

  @override
  TaskEither<SecureStorageException, Tokenization> call() {
    return TaskEither(() => repository.getToken());
  }
}
