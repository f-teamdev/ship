import 'package:fpdart/fpdart.dart';

import '../entities/tokenization.dart';
import '../exceptions/exceptions.dart';

abstract class AuthRepository {
  Future<Either<AuthException, Tokenization>> loginWithEmailAndPassword(String credentials);
  Future<Either<AuthException, Tokenization>> refreshToken(String refreshToken);
  Future<Either<AuthException, Unit>> checkToken(String accessToken);
}
