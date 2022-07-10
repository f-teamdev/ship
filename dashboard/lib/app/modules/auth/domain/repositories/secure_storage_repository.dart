import 'package:fpdart/fpdart.dart';
import 'package:ship_dashboard/app/modules/auth/domain/entities/tokenization.dart';

import '../exceptions/exceptions.dart';

abstract class SecureStorageRepository {
  Future<Either<SecureStorageException, Unit>> saveToken(Tokenization tokenization);
  Future<Either<SecureStorageException, Tokenization>> getToken();
  Future<Either<SecureStorageException, Unit>> removeToken();
}
