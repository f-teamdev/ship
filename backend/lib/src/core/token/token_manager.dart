abstract class TokenManager {
  int expireTime([Duration duration = const Duration(hours: 3)]) => Duration(milliseconds: DateTime.now().add(duration).millisecondsSinceEpoch).inSeconds;

  String generateToken(Map<String, dynamic> claimsMap);

  Future<Map<String, dynamic>> validateToken(String encoded, String audience);
}
