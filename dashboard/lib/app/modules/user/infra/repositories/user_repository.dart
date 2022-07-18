import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user.dart';
import '../../domain/exceptions/exceptions.dart';
import '../../domain/repositories/user_repository.dart';
import '../adapters/user_adapter.dart';
import '../datasources/user_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<Either<UserException, User>> getLoggedUser() async {
    try {
      final userMap = await datasource.getLoggedUser();
      final user = UserAdapter.fromJson(userMap);
      return Right(user);
    } on UserException catch (e) {
      return Left(e);
    }
  }
}
