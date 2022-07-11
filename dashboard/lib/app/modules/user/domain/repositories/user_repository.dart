import 'package:fpdart/fpdart.dart';
import 'package:ship_dashboard/app/modules/user/domain/entities/user.dart';
import 'package:ship_dashboard/app/modules/user/domain/exceptions/exceptions.dart';

abstract class UserRepository {
  Future<Either<UserException, User>> getLoggedUser();
}
