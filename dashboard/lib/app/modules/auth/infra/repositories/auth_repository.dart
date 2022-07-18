import 'package:fpdart/fpdart.dart';

import '../../domain/entities/tokenization.dart';
import '../../domain/exceptions/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../adapters/tokenization_adapter.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<Either<AuthException, Tokenization>> loginWithEmailAndPassword(String credentials) async {
    try {
      final map = await datasource.login(credentials);
      return Right(TokenizationAdapter.fromJson(map));
    } on AuthException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AuthException, Tokenization>> refreshToken(String refreshToken) async {
    try {
      final map = await datasource.refreshToken(refreshToken);
      return Right(TokenizationAdapter.fromJson(map));
    } on AuthException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AuthException, Unit>> checkToken(String accessToken) async {
    try {
      await datasource.checkToken(accessToken);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(e);
    }
  }
}
