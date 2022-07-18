import 'dart:convert';

import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/encrypt/encrypt_service.dart';
import '../../../../shared/services/local_storage/local_storage_service.dart';
import '../../domain/entities/tokenization.dart';
import '../../domain/exceptions/exceptions.dart';
import '../../domain/repositories/secure_storage_repository.dart';
import '../adapters/tokenization_adapter.dart';

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
    return const Right(unit);
  }

  @override
  Future<Either<SecureStorageException, Unit>> removeToken() async {
    await storage.remove(_TOKENIZATION_KEY);
    return const Right(unit);
  }
}
