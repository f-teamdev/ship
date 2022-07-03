class User {
  final int id;
  final DateTime createdAt;
  final String email;
  final String name;
  final String? imageUrl;
  final bool active;
  final String password;
  final Role role;

 User({
   required  this.id,
   required  this.createdAt,
   required  this.email,
   required  this.name,
    this.imageUrl,
   this.active = true,
   required  this.password,
   this.role = Role.dev,
 });

static User fromJson(Map json) {
return User(
    id: json['id'],
    createdAt: json['createdAt'],
    email: json['email'],
    name: json['name'],
    imageUrl: json['imageUrl'],
    active: json['active'],
    password: json['password'],
    role: json['role'],
 );
}

}

enum Role {
dev,
manager,
admin,
}


