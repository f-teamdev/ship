import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';
import 'package:backend/src/modules/user/domain/usecases/update_password.dart';
import 'package:backend/src/modules/user/infra/adapters/user_adapter.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<Either<UserException, UserEntity>> createUser(UserEntity userEntity) async {
    try {
      final userMap = await datasource.createUser(userEntity);
      return Right(UserAdapter.fromJson(userMap));
    } on UserException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<UserException, UserEntity>> updateUser(UserEntity userEntity) async {
    try {
      final userMap = await datasource.updateUser(userEntity);
      return Right(UserAdapter.fromJson(userMap));
    } on UserException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<UserException, Unit>> updatePassword(UpdatePasswordParams parameters) async {
    try {
      await datasource.updatePassword(
        id: parameters.id,
        newPassword: parameters.newPassword,
      );
      return Right(unit);
    } on UserException catch (e) {
      return Left(e);
    }
  }
}
