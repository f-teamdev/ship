enum UserRole {
  dev,
  manager,
  admin,
}

class User {
  final int id;
  final String email;
  final String name;
  final String? imageUrl;
  final bool active;
  final UserRole role;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.imageUrl,
    required this.active,
    required this.role,
  });

  factory User.empty() {
    return User(
      active: false,
      email: '',
      id: -1,
      imageUrl: '',
      name: '',
      role: UserRole.dev,
    );
  }
}
