import 'package:fpdart/fpdart.dart';
import 'package:ship_dashboard/app/modules/auth/domain/entities/tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/domain/exceptions/exceptions.dart';

abstract class AuthRepository {
  Future<Either<AuthException, Tokenization>> loginWithEmailAndPassword(String credentials);
  Future<Either<AuthException, Tokenization>> refreshToken(String refreshToken);
}
