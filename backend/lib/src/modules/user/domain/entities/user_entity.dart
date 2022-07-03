class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? imageUrl;
  final bool active;
  final UserRole role;

  UserEntity({
    required this.name,
    required this.email,
    required this.active,
    this.imageUrl,
    required this.role,
    required this.id,
  });
}

enum UserRole { dev, manager, admin }
