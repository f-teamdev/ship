import 'dart:convert';

import 'package:fpdart/fpdart.dart';

import '../entities/tokenization.dart';
import '../exceptions/exceptions.dart';
import '../params/login_credentials.dart';
import '../repositories/auth_repository.dart';

abstract class Login {
  TaskEither<AuthException, Tokenization> call(LoginCredentials credentials);
}

class LoginImpl implements Login {
  final AuthRepository _repository;

  LoginImpl(this._repository);

  @override
  TaskEither<AuthException, Tokenization> call(LoginCredentials credentials) {
    return credentials
        .validate() //
        .map(_baseAuthCredential)
        .bindFuture(_repository.loginWithEmailAndPassword);
  }

  String _baseAuthCredential(LoginCredentials credentials) {
    String basic = '${credentials.email}:${credentials.password}';
    basic = base64Encode(basic.codeUnits);
    return basic;
  }
}
