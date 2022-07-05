import 'package:backend/backend.dart';
import 'package:backend/src/core/services/bcrypt_service.dart';
import 'package:backend/src/modules/auth/domain/entities/tokenization.dart';
import 'package:backend/src/modules/auth/domain/errors/errors.dart';
import 'package:backend/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:backend/src/modules/auth/external/errors/errors.dart';
import 'package:backend/src/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/token/token_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;
  final TokenManager tokenManager;
  final BCryptService bCryptService;
  final DotEnvService dotEnvService;
  late final Duration _expiration = Duration(seconds: int.tryParse(dotEnvService['JWT_ACCESS_TOKEN_EXPIRESIN'] ?? '') ?? 600);
  late final Duration _refreshTokenExpiration = Duration(seconds: int.tryParse(dotEnvService['JWT_REFRESH_TOKEN_EXPIRESIN'] ?? '') ?? 259200);

  AuthRepositoryImpl(this.datasource, this.tokenManager, this.bCryptService, this.dotEnvService);

  @override
  Future<Either<AuthException, Tokenization>> fromCredentials({required String email, required String password}) async {
    try {
      final userMap = await datasource.fromCredentials(email: email);

      if (!bCryptService.checkPassword(password, userMap['password'])) {
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
  Future<Either<AuthException, Map<String, dynamic>>> checkToken({required String accessToken}) async {
    try {
      final claims = await tokenManager.validateToken(accessToken);
      return Right(claims);
    } on AuthException catch (e) {
      return Left(e);
    }
  }
}
