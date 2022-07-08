import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/user_repository.dart';

abstract class UpdateUser {
  Future<Either<UserException, UserEntity>> call(UpdateUserParams params);
}

class UpdateUserImpl implements UpdateUser {
  final UserRepository repository;

  UpdateUserImpl(this.repository);

  @override
  Future<Either<UserException, UserEntity>> call(UpdateUserParams params) async {
    if (params.id < 1) {
      return Left(UserUpdateValidate('id < 1'));
    }

    if (params.name != null && params.name!.split(' ').length < 2) {
      return left(UserUpdateValidate('needs lastname'));
    }

    return await repository.updateUser(params);
  }
}

class UpdateUserParams {
  final int id;
  final String? name;
  final String? email;
  final String? imageUrl;
  final bool? active;
  final UserRole? role;

  UpdateUserParams({
    required this.id,
    this.name,
    this.email,
    this.imageUrl,
    this.active,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (active != null) 'active': active,
      if (role != null) 'role': role!.name,
    };
  }

  factory UpdateUserParams.fromJson(map) => UpdateUserParams(
        id: map['id']?.toInt() ?? 0,
        name: map['name'],
        email: map['email'],
        imageUrl: map['imageUrl'],
        active: map['active'],
        role: map['role'] != null ? UserRole.values.firstWhere((e) => e.name == map['role']) : null,
      );
}
