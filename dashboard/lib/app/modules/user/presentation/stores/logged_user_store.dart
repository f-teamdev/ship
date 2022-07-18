import 'package:flutter_triple/flutter_triple.dart';

import '../../../../shared/adapters/either_adapter.dart';
import '../../domain/entities/user.dart';
import '../../domain/exceptions/exceptions.dart';
import '../../domain/usecases/logged_user.dart';

class LoggedUserStore extends StreamStore<UserException, User> {
  final LoggedUser loggedUserUsecase;

  LoggedUserStore(this.loggedUserUsecase) : super(User.empty());

  void removeUser() => update(User.empty());

  Future<void> getLoggedUser() async {
    await executeEither(() => CustomEitherAdapter.adapter(loggedUserUsecase()));
  }
}
