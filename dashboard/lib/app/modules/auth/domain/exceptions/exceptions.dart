import '../../../../shared/exceptions/exceptions.dart';
import '../../../../shared/services/network/network_exception.dart';

class AuthException extends CustomException {
  final NetworkException? networkException;
  const AuthException(super.message, [super.stackTrace, this.networkException]);
}

class SecureStorageException extends AuthException {
  const SecureStorageException(super.message, [super.stackTrace]);
}
