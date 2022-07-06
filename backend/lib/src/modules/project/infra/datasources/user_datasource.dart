abstract class UserDatasource {
  Future<dynamic> createUser(Map<String, dynamic> user);
  Future<dynamic> updateUser(Map<String, dynamic> user);
  Future<dynamic> getUserById(int id);
  Future<List> getUsers();
}
