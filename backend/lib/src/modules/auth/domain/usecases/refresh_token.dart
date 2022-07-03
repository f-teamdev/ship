import 'package:backend/src/modules/auth/domain/entities/tokenization.dart';
import 'package:backend/src/modules/auth/domain/errors/errors.dart';
import 'package:backend/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

abstract class RefreshToken {
  Future<Either<AuthException, Tokenization>> call({required String refreshToken});
}

class RefreshTokenImpl implements RefreshToken {
  final AuthRepository repository;

  RefreshTokenImpl(this.repository);

  @override
  Future<Either<AuthException, Tokenization>> call({required String refreshToken}) async {
    return await repository.refresh(refreshToken: refreshToken);
  }
}
