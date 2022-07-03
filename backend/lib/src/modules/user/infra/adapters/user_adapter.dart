import 'package:backend/src/modules/user/domain/entities/user_entity.dart';

class UserAdapter {
  UserAdapter._();

  static Map toJson(UserEntity user) {
    return {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'imageUrl': user.imageUrl,
      'active': user.active,
      'role': user.role,
    };
  }

  static UserEntity fromJson(dynamic json) {
    return UserEntity(
      id: json['id'],
      name: json['id'],
      email: json['id'],
      imageUrl: json['id'],
      active: json['id'],
      role: json['id'],
    );
  }
}
