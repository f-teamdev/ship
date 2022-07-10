import 'package:fpdart/fpdart.dart';

import '../exceptions/exceptions.dart';
import 'value_objects/email.dart';
import 'value_objects/password.dart';

class LoginCredentials {
  Email _email = Email('');
  setEmail(String value) => _email = Email(value);
  Email get email => _email;

  Password _password = Password('');
  setPassword(String value) => _password = Password(value);
  Password get password => _password;

  Either<AuthException, LoginCredentials> validate() {
    return _email
        .validate()
        .bind(
          _password.validate,
        )
        .mapLeft(AuthException.new)
        .map((a) => this);
  }
}
