import 'package:fpdart/src/either.dart';
import 'package:ship_dashboard/app/modules/user/domain/entities/user.dart';
import 'package:ship_dashboard/app/modules/user/domain/exceptions/exceptions.dart';
import 'package:ship_dashboard/app/modules/user/domain/repositories/user_repository.dart';
import 'package:ship_dashboard/app/modules/user/infra/adapters/user_adapter.dart';

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
