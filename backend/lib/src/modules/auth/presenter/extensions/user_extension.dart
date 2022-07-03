import 'dart:convert';

import '../../domain/entities/user.dart';

extension UserExtension on User {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  String toJson() => jsonEncode(toMap());
}
