import '../../domain/entities/tokenization.dart';

class TokenizationAdapter {
  TokenizationAdapter._();

  static Tokenization fromJson(dynamic json) {
    return Tokenization(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiresIn: json['expiresIn'],
    );
  }

  static Map<String, dynamic> toJson(Tokenization tokenization) {
    return {
      'accessToken': tokenization.accessToken,
      'refreshToken': tokenization.refreshToken,
      'expiresIn': tokenization.expiresIn,
    };
  }
}
