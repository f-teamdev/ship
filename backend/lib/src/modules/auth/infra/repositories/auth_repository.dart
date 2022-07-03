import 'package:backend/src/modules/auth/domain/entities/tokenization.dart';
import 'package:backend/src/modules/auth/domain/errors/errors.dart';
import 'package:backend/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:backend/src/modules/auth/external/errors/errors.dart';
import 'package:backend/src/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/token/token_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;
  final TokenManager tokenManager;
  final Duration _expiration = const Duration(minutes: 3);
  final Duration _refreshTokenExpiration = const Duration(days: 3);

  AuthRepositoryImpl(this.datasource, this.tokenManager);

  @override
  Future<Either<AuthException, Tokenization>> fromCredentials({required String email, required String password}) async {
    try {
      final userMap = await datasource.fromCredentials(email: email);

      if (!BCrypt.checkpw(password, userMap['password'])) {
        return Left(NotAuthorized('Password error'));
      }

      final refreshToken = Uuid().v1();
      userMap.remove('password');
      final tokenization = _generateTokenization(userMap, refreshToken);

      await datasource.saveRefreshToken(
        key: refreshToken,
        value: userMap,
        expiresIn: _refreshTokenExpiration,
      );

      return Right(tokenization);
    } on AuthException catch (e) {
      return Left(e);
    }
  }

  Tokenization _generateTokenization(Map claims, String newRefreshToken) {
    final accessToken = tokenManager.generateToken({
      'exp': tokenManager.expireTime(_expiration),
      ...claims,
    });

    final tokenization = Tokenization(expiresIn: _expiration.inSeconds, accessToken: accessToken, refreshToken: newRefreshToken);
    return tokenization;
  }

  @override
  Future<Either<AuthException, Tokenization>> refresh({required String refreshToken}) async {
    try {
      final userMap = await datasource.removeToken(token: refreshToken);

      refreshToken = Uuid().v1();
      await datasource.saveRefreshToken(
        key: refreshToken,
        value: userMap,
        expiresIn: _refreshTokenExpiration,
      );
      final tokenization = _generateTokenization(userMap, refreshToken);
      return Right(tokenization);
    } on AuthException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AuthException, Unit>> checkToken({required String accessToken}) async {
    try {
      await tokenManager.validateToken(accessToken);
      return Right(unit);
    } on AuthException catch (e) {
      return Left(e);
    }
  }
}
