import 'package:backend/src/core/services/bcrypt_service.dart';
import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';
import 'package:backend/src/modules/user/domain/usecases/update_password.dart';
import 'package:backend/src/modules/user/infra/adapters/user_adapter.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;
  final BCryptService bCryptService;

  UserRepositoryImpl(this.datasource, this.bCryptService);

  @override
  Future<Either<UserException, UserEntity>> createUser(UserEntity userEntity) async {
    try {
      var userCreation = <String, dynamic>{
        'name': userEntity.name,
        'email': userEntity.email,
        'imageUrl': userEntity.imageUrl,
        'role': userEntity.role.name,
        'active': userEntity.active,
        'password': bCryptService.generatePassword('123'),
      };

      final userMap = await datasource.createUser(userCreation);
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

  @override
  Future<Either<UserException, UserEntity>> getUserById(int id) async {
    try {
      final userMap = await datasource.getUserById(id);
      return Right(UserAdapter.fromJson(userMap));
    } on UserException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<UserException, List<UserEntity>>> getUsers() async {
    try {
      final result = await datasource.getUsers();
      final users = result.map(UserAdapter.fromJson).toList();
      return Right(users);
    } on UserException catch (e) {
      return Left(e);
    }
  }
}
