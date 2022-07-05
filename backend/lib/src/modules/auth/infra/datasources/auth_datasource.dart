abstract class AuthDatasource {
  Future<dynamic> fromCredentials({required String email});
  Future fromId({required int id});
  Future<Map<String, dynamic>> removeToken({required String token});
  Future<void> saveRefreshToken({
    required String key,
    required Map<String, dynamic> value,
    required Duration expiresIn,
  });
  Future<dynamic> updatePassword({required int id, required String newPassword});
}
