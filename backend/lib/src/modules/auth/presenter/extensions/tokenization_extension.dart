import 'dart:convert';

import '../../domain/entities/tokenization.dart';

extension UserExtension on Tokenization {
  Map<String, dynamic> toMap() {
    return {
      'expires_id': expiresIn,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  String toJson() => jsonEncode(toMap());
}
