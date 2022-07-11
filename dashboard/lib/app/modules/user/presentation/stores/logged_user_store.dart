import 'package:flutter_triple/flutter_triple.dart';
import 'package:ship_dashboard/app/modules/user/domain/entities/user.dart';
import 'package:ship_dashboard/app/modules/user/domain/exceptions/exceptions.dart';
import 'package:ship_dashboard/app/modules/user/domain/usecases/logged_user.dart';
import 'package:ship_dashboard/app/shared/adapters/either_adapter.dart';

class LoggedUserStore extends StreamStore<UserException, User> {
  final LoggedUser loggedUserUsecase;

  LoggedUserStore(this.loggedUserUsecase) : super(User.empty());

  void removeUser() => update(User.empty());

  Future<void> getLoggedUser() async {
    await executeEither(() => CustomEitherAdapter.adapter(loggedUserUsecase()));
  }
}
