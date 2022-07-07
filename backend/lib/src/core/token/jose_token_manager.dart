import 'package:backend/src/core/token/token_manager.dart';
import 'package:backend/src/modules/auth/external/errors/errors.dart';
import 'package:jose/jose.dart';

class JoseTokenManager extends TokenManager {
  final key = JsonWebKey.fromJson({
    'kty': 'oct',
    'k': 'AyM1SysPpbyDfgZld3umj1qzKObwVMkoqQ-EstJQLr_T-1qS0gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr1Z9CAow',
  });

  @override
  String generateToken(Map<String, dynamic> claimsMap) {
    var claims = JsonWebTokenClaims.fromJson(claimsMap);

    // JsonWebSignatureBuilder
    var builder = JsonWebSignatureBuilder();

    // set the content
    builder.jsonContent = claims.toJson();

    // add a key to sign, can only add one for JWT
    builder.addRecipient(key, algorithm: 'HS256');

    // build the jws
    var jws = builder.build();

    return jws.toCompactSerialization();
  }

  @override
  Future<Map<String, dynamic>> validateToken(String encoded, String audience) async {
    // create key store to verify the signature
    var keyStore = JsonWebKeyStore()..addKey(key);

    // applicable for JWT inside JWE
    var jwt = await JsonWebToken.decodeAndVerify(encoded, keyStore);

    var violations = jwt.claims.validate(clientId: audience);

    if (violations.isNotEmpty) {
      final list = violations.map((e) => e.toString()).toList();
      throw JWTViolations('One or more violations in current access token', list);
    }

    return jwt.claims.toJson();
  }
}
