import 'package:backend/src/modules/project/domain/entities/project_entity.dart';
import 'package:backend/src/modules/project/domain/errors/errors.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/project_repository.dart';

abstract class UpdateProject {
  Future<Either<ProjectException, ProjectEntity>> call(UpdateProjectParams params);
}

class UpdateProjectImpl implements UpdateProject {
  final ProjectRepository repository;

  UpdateProjectImpl(this.repository);

  @override
  Future<Either<ProjectException, ProjectEntity>> call(UpdateProjectParams params) async {
    if (params.id < 1) {
      return Left(ProjectUpdateValidate('id < 1'));
    }

    if (params.title != null && params.title!.isEmpty) {
      return left(ProjectUpdateValidate('title is empty'));
    }

    return await repository.updateProject(params);
  }
}

class UpdateProjectParams {
  final int id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final bool? active;

  UpdateProjectParams({
    required this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (active != null) 'active': active,
    };
  }

  factory UpdateProjectParams.fromJson(map) => UpdateProjectParams(
        id: map['id']?.toInt() ?? 0,
        title: map['title'],
        description: map['description'],
        imageUrl: map['imageUrl'],
        active: map['active'],
      );
}
