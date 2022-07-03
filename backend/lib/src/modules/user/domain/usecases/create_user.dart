import 'package:fpdart/fpdart.dart';
import 'package:string_validator/string_validator.dart' as validator;

import '../entities/user_entity.dart';
import '../errors/errors.dart';
import '../repositories/user_repository.dart';

abstract class CreateUser {
  Future<Either<UserException, UserEntity>> call(UserEntity params);
}

class CreateUserImpl implements CreateUser {
  final UserRepository repository;

  CreateUserImpl(this.repository);

  @override
  Future<Either<UserException, UserEntity>> call(UserEntity params) async {
    if (!validator.isEmail(params.email)) {
      return left(UserCreationValidate('Email not valid'));
    }

    if (params.name.split(' ').length < 2) {
      return left(UserCreationValidate('needs lastname'));
    }

    return await repository.createUser(params);
  }
}
