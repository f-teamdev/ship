import 'package:backend/src/modules/user/domain/entities/user_entity.dart';

abstract class UserDatasource {
  Future<dynamic> createUser(UserEntity user);
  Future<dynamic> updateUser(UserEntity user);
  Future<dynamic> updatePassword({required int id, required String newPassword});
}
