import 'dart:convert';

import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:ship_dashboard/app/modules/auth/domain/entities/tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/domain/exceptions/exceptions.dart';
import 'package:ship_dashboard/app/modules/auth/domain/repositories/secure_storage_repository.dart';
import 'package:ship_dashboard/app/modules/auth/infra/adapters/tokenization_adapter.dart';
import 'package:ship_dashboard/app/shared/services/local_storage/local_storage_service.dart';

import '../../../../shared/services/encrypt/encrypt_service.dart';

const _TOKENIZATION_KEY = '_TOKENIZATION_KEY';

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  final LocalStorage storage;
  final EncryptService _encryptService;

  SecureStorageRepositoryImpl(this.storage, this._encryptService);

  @override
  Future<Either<SecureStorageException, Tokenization>> getToken() async {
    final encryptedToken = await storage.get(_TOKENIZATION_KEY);
    if (encryptedToken.isEmpty) {
      return Left(SecureStorageException('token is empty', StackTrace.current));
    }
    final tokenString = _encryptService.decrypt(encryptedToken);
    final tokenization = TokenizationAdapter.fromJson(jsonDecode(tokenString));
    return Right(tokenization);
  }

  @override
  Future<Either<SecureStorageException, Unit>> saveToken(Tokenization tokenization) async {
    final mapToken = TokenizationAdapter.toJson(tokenization);
    final encryptedText = _encryptService.encrypt(jsonEncode(mapToken));
    await storage.put(_TOKENIZATION_KEY, encryptedText);
    return Right(unit);
  }
}
