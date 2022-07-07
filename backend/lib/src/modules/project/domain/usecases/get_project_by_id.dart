import 'package:backend/src/modules/project/domain/errors/errors.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

abstract class GetProjectById {
  Future<Either<ProjectException, ProjectEntity>> call(int id);
}

class GetProjectByidImpl implements GetProjectById {
  final ProjectRepository projectRepository;

  GetProjectByidImpl(this.projectRepository);

  @override
  Future<Either<ProjectException, ProjectEntity>> call(int id) async {
    if (id < 1) {
      return Left(GetProjectValidate('id < 1'));
    }

    return await projectRepository.getProjectById(id);
  }
}
