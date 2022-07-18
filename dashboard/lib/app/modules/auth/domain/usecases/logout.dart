import 'package:fpdart/fpdart.dart';

import '../exceptions/exceptions.dart';
import '../repositories/secure_storage_repository.dart';

abstract class Logout {
  TaskEither<AuthException, Unit> call();
}

class LogoutImpl implements Logout {
  final SecureStorageRepository secureStorageRepository;

  LogoutImpl(this.secureStorageRepository);
  @override
  TaskEither<AuthException, Unit> call() {
    return TaskEither(() => secureStorageRepository.removeToken());
  }
}
