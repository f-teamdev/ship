import 'package:backend/src/modules/project/domain/errors/errors.dart';
import 'package:fpdart/fpdart.dart';
import 'package:string_validator/string_validator.dart' as validator;

import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

abstract class CreateProject {
  Future<Either<ProjectException, ProjectEntity>> call(ProjectEntity params);
}

class CreateProjectImpl implements CreateProject {
  final ProjectRepository repository;

  CreateProjectImpl(this.repository);

  @override
  Future<Either<ProjectException, ProjectEntity>> call(ProjectEntity params) async {
    if (params.title.isEmpty) {
      return left(ProjectCreationValidate('title is empty'));
    }

    if (params.imageUrl != null && !validator.isEmail(params.imageUrl!)) {
      return left(ProjectCreationValidate('Invalid imageUrl'));
    }

    return await repository.createProject(params);
  }
}
