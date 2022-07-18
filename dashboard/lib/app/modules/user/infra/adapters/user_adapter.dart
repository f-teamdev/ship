import '../../domain/entities/user.dart';

class UserAdapter {
  UserAdapter._();

  static User fromJson(dynamic json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      active: json['active'],
      role: UserRole.values.firstWhere(
        (element) => element.name == json['role'],
        orElse: () => UserRole.dev,
      ),
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'imageUrl': user.imageUrl,
      'active': user.active,
      'role': user.role.name,
    };
  }
}
