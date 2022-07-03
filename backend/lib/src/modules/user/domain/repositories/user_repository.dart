import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';
import 'package:fpdart/fpdart.dart';

import '../usecases/update_password.dart';

abstract class UserRepository {
  Future<Either<UserException, UserEntity>> createUser(UserEntity parameters);
  Future<Either<UserException, UserEntity>> updateUser(UserEntity parameters);
  Future<Either<UserException, Unit>> updatePassword(UpdatePasswordParams parameters);
}
