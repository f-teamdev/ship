abstract class UserException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const UserException(this.message, [this.stackTrace]);

  @override
  String toString() {
    return '$runtimeType: $message\n${stackTrace ?? ''}';
  }
}

class UserCreationValidate extends UserException {
  UserCreationValidate(super.message);
}

class UserUpdateValidate extends UserException {
  UserUpdateValidate(super.message);
}

class GetUserValidate extends UserException {
  GetUserValidate(super.message);
}

class UserNotFound extends UserException {
  UserNotFound(super.message);
}

class PasswordValidate extends UserException {
  PasswordValidate(super.message);
}
