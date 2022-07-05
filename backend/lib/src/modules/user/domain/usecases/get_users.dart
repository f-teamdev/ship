import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';
import 'package:backend/src/modules/user/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

abstract class GetUsers {
  Future<Either<UserException, List<UserEntity>>> call();
}

class GetUsersImpl implements GetUsers {
  final UserRepository userRepository;

  GetUsersImpl(this.userRepository);

  @override
  Future<Either<UserException, List<UserEntity>>> call() async {
    return await userRepository.getUsers();
  }
}
