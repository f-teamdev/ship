import 'package:backend/backend.dart';
import 'package:backend/src/core/services/bcrypt_service.dart';
import 'package:backend/src/modules/auth/domain/entities/tokenization.dart';
import 'package:backend/src/modules/auth/domain/errors/errors.dart';
import 'package:backend/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:backend/src/modules/auth/domain/usecases/update_password.dart';
import 'package:backend/src/modules/auth/external/errors/errors.dart';
import 'package:backend/src/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:fpdart/fpdart.dart';

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

      userMap.remove('password');
      final accessToken = _generateTokenization(userMap, 'accessToken', _expiration);
      final refreshToken = _generateTokenization(userMap, 'refreshToken', _refreshTokenExpiration);

      final tokenization = Tokenization(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: _expiration.inSeconds,
      );

      return Right(tokenization);
    } on AuthException catch (e) {
      return Left(e);
    }
  }

  String _generateTokenization(
    Map claims,
    String clientId,
    Duration expiration,
  ) {
    final accessToken = tokenManager.generateToken({
      'exp': tokenManager.expireTime(expiration),
      'aud': clientId,
      ...claims,
    });

    return accessToken;
  }

  @override
  Future<Either<AuthException, Tokenization>> refresh({required String refreshToken}) async {
    try {
      final claims = await tokenManager.validateToken(refreshToken, 'refreshToken');
      final id = claims['id'] as int;

      final userMap = await datasource.fromId(id: id);

      final accessToken = _generateTokenization(userMap, 'accessToken', _expiration);
      refreshToken = _generateTokenization(userMap, 'refreshToken', _refreshTokenExpiration);

      final tokenization = Tokenization(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: _expiration.inSeconds,
      );

      return Right(tokenization);
    } on AuthException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AuthException, Map<String, dynamic>>> checkToken({required String accessToken}) async {
    try {
      final claims = await tokenManager.validateToken(accessToken, 'accessToken');
      return Right(claims);
    } on AuthException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AuthException, Unit>> updatePassword(UpdatePasswordParams parameters) async {
    try {
      final userMap = await datasource.fromId(
        id: parameters.id,
      );

      if (!bCryptService.checkPassword(parameters.password, userMap['password'])) {
        return Left(NotAuthorized('Password error'));
      }

      await datasource.updatePassword(
        id: parameters.id,
        newPassword: bCryptService.generatePassword(parameters.newPassword),
      );
      return Right(unit);
    } on AuthException catch (e) {
      return Left(e);
    }
  }
}
