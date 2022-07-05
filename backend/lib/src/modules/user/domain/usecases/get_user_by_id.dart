import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';
import 'package:backend/src/modules/user/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

abstract class GetUserById {
  Future<Either<UserException, UserEntity>> call(int id);
}

class GetUserByidImpl implements GetUserById {
  final UserRepository userRepository;

  GetUserByidImpl(this.userRepository);

  @override
  Future<Either<UserException, UserEntity>> call(int id) async {
    if (id < 1) {
      return Left(GetUserValidate('id < 1'));
    }

    return await userRepository.getUserById(id);
  }
}
