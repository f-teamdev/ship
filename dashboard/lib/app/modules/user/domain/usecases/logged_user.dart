import 'package:fpdart/fpdart.dart';
import 'package:ship_dashboard/app/modules/user/domain/entities/user.dart';

import '../exceptions/exceptions.dart';
import '../repositories/user_repository.dart';

abstract class LoggedUser {
  TaskEither<UserException, User> call();
}

class LoggedUserImpl implements LoggedUser {
  final UserRepository repository;

  LoggedUserImpl(this.repository);
  @override
  TaskEither<UserException, User> call() {
    return TaskEither(() => repository.getLoggedUser());
  }
}
