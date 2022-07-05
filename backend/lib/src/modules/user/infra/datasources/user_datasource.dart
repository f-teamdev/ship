import 'package:backend/src/modules/user/domain/entities/user_entity.dart';

abstract class UserDatasource {
  Future<dynamic> createUser(Map<String, dynamic> user);
  Future<dynamic> updateUser(UserEntity user);
  Future<dynamic> updatePassword({required int id, required String newPassword});
  Future<dynamic> getUserById(int id);
  Future<List> getUsers();
}
