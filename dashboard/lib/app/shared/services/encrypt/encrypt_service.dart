import 'package:encrypt/encrypt.dart';

class EncryptService {
  final _key = Key.fromUtf8('PLQdvnFlpL2TAyLcZ2RuNldL9dg1Hs2mxlMJfYO6dN0=');
  final _iv = IV.fromLength(16);

  late final _encrypter = Encrypter(AES(_key));

  String encrypt(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedText) {
    final encrypted = Encrypted.fromBase64(encryptedText);
    final decrypted = _encrypter.decrypt(encrypted, iv: _iv);
    return decrypted;
  }
}
