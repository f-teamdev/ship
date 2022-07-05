import 'package:bcrypt/bcrypt.dart';

class BCryptService {
  String generatePassword(String password) {
    final salt = BCrypt.gensalt();
    return BCrypt.hashpw(password, salt);
  }

  bool checkPassword(String password, String hash) {
    return BCrypt.checkpw(password, hash);
  }
}
