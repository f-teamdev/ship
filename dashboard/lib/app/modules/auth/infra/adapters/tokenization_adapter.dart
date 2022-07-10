import '../../domain/entities/tokenization.dart';

class TokenizationAdapter {
  TokenizationAdapter._();

  static Tokenization fromJson(dynamic json) {
    return Tokenization(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_id'],
    );
  }

  static Map<String, dynamic> toJson(Tokenization tokenization) {
    return {
      'access_token': tokenization.accessToken,
      'refresh_token': tokenization.refreshToken,
      'expires_id': tokenization.expiresIn,
    };
  }
}
