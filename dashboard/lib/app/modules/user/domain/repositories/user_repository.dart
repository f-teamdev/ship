import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../exceptions/exceptions.dart';

abstract class UserRepository {
  Future<Either<UserException, User>> getLoggedUser();
}
