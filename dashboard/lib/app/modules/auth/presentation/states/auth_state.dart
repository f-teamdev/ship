import 'package:ship_dashboard/app/modules/auth/domain/entities/tokenization.dart';

abstract class AuthState {}

class Unlogged implements AuthState {}

class AuthInProgress implements AuthState {}

class Logged implements AuthState {
  final Tokenization tokenization;

  Logged(this.tokenization);
}
