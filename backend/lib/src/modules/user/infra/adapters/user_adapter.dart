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
      'role': user.role.name,
    };
  }

  static UserEntity fromJson(dynamic json) {
    return UserEntity(
      id: json['id'] ?? -1,
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      active: json['active'] ?? true,
      role: UserRole.values.firstWhere((role) => role.name == json['role'], orElse: () => UserRole.dev),
    );
  }
}
