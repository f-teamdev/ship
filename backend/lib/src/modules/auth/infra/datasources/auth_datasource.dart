abstract class AuthDatasource {
  Future<dynamic> fromCredentials({required String email});
  Future<Map<String, dynamic>> removeToken({required String token});
  Future<void> saveRefreshToken({
    required String key,
    required Map<String, dynamic> value,
    required Duration expiresIn,
  });
}
