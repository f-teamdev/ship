import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/user_repository.dart';

abstract class UpdateUser {
  Future<Either<UserException, UserEntity>> call(UserEntity params);
}

class UpdateUserImpl implements UpdateUser {
  final UserRepository repository;

  UpdateUserImpl(this.repository);

  @override
  Future<Either<UserException, UserEntity>> call(UserEntity params) async {
    if (params.id < 1) {
      return Left(UserUpdateValidate('id < 1'));
    }

    if (params.name.split(' ').length < 2) {
      return left(UserUpdateValidate('needs lastname'));
    }

    return await repository.updateUser(params);
  }
}
