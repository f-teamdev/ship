import 'package:backend/src/modules/project/domain/errors/errors.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

abstract class GetProjects {
  Future<Either<ProjectException, List<ProjectEntity>>> call();
}

class GetProjectsImpl implements GetProjects {
  final ProjectRepository projectRepository;

  GetProjectsImpl(this.projectRepository);

  @override
  Future<Either<ProjectException, List<ProjectEntity>>> call() async {
    return await projectRepository.getProjects();
  }
}
