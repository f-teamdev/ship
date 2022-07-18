import '../../domain/entities/tokenization.dart';

abstract class AuthState {}

class Unlogged implements AuthState {}

class OfflineAuth implements AuthState {}

class AuthInProgress implements AuthState {}

class Logged implements AuthState {
  final Tokenization tokenization;

  Logged(this.tokenization);
}