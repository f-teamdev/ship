import 'package:backend/src/modules/auth/domain/errors/errors.dart';
import 'package:backend/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

abstract class CheckToken {
  Future<Either<AuthException, Map<String, dynamic>>> call({required String accessToken});
}

class CheckTokenImpl implements CheckToken {
  final AuthRepository repository;

  CheckTokenImpl(this.repository);

  @override
  Future<Either<AuthException, Map<String, dynamic>>> call({required String accessToken}) async {
    return await repository.checkToken(accessToken: accessToken);
  }
}
