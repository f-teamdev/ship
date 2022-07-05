import 'package:fpdart/fpdart.dart';
import 'package:string_validator/string_validator.dart' as validator;

import '../errors/errors.dart';
import '../repositories/auth_repository.dart';

abstract class UpdatePassword {
  Future<Either<AuthException, Unit>> call(UpdatePasswordParams params);
}

class UpdatePasswordImpl implements UpdatePassword {
  final AuthRepository repository;

  UpdatePasswordImpl(this.repository);

  @override
  Future<Either<AuthException, Unit>> call(UpdatePasswordParams params) async {
    if (params.password == params.newPassword) {
      return left(PasswordValidate('New password must be diff'));
    }

    if (!validator.matches(params.newPassword, r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})')) {
      return left(PasswordValidate(r'''Password not strength:
      - Minimal 6 characters.
      - The string must contain at least 1 lowercase alphabetical character.
      - The string must contain at least 1 uppercase alphabetical character.
      - The string must contain at least 1 numeric character.
      - The string must contain at least one special character, but we are escaping reserved RegEx characters to avoid conflict.
      - The string must be eight characters or longer.
      '''));
    }

    return await repository.updatePassword(params);
  }
}

class UpdatePasswordParams {
  final int id;
  final String password;
  final String newPassword;

  UpdatePasswordParams({
    required this.id,
    required this.password,
    required this.newPassword,
  });
}
