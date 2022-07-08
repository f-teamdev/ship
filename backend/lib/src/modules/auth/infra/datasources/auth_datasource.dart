abstract class AuthDatasource {
  Future<dynamic> fromCredentials({required String email});
  Future fromId({required int id});
  Future<dynamic> updatePassword({required int id, required String newPassword});
}
