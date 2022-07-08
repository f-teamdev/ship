import '../../domain/entities/project_entity.dart';

class ProjectAdapter {
  ProjectAdapter._();

  static Map toJson(ProjectEntity user) {
    return {
      'id': user.id,
      'title': user.title,
      'description': user.description,
      'imageUrl': user.imageUrl,
      'active': user.active,
    };
  }

  static ProjectEntity fromJson(dynamic json) {
    return ProjectEntity(
      id: json['id'] ?? -1,
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      active: json['active'] ?? true,
    );
  }
}
