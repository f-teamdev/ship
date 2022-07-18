import 'package:fpdart/fpdart.dart';

import '../entities/tokenization.dart';
import '../exceptions/exceptions.dart';

abstract class SecureStorageRepository {
  Future<Either<SecureStorageException, Unit>> saveToken(Tokenization tokenization);
  Future<Either<SecureStorageException, Tokenization>> getToken();
  Future<Either<SecureStorageException, Unit>> removeToken();
}
