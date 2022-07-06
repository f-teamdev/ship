import 'package:backend/src/modules/project/domain/errors/errors.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/project_entity.dart';
import '../usecases/update_projects.dart';

abstract class ProjectRepository {
  Future<Either<ProjectException, ProjectEntity>> createProject(ProjectEntity parameters);
  Future<Either<ProjectException, ProjectEntity>> updateProject(UpdateProjectParams parameters);
  Future<Either<ProjectException, ProjectEntity>> getProjectById(int id);
  Future<Either<ProjectException, List<ProjectEntity>>> getProjects();
}
