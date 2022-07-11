import 'package:ship_dashboard/app/shared/exceptions/exceptions.dart';

class AuthException extends CustomException {
  const AuthException(super.message, [super.stackTrace]);
}

class SecureStorageException extends AuthException {
  const SecureStorageException(super.message, [super.stackTrace]);
}
