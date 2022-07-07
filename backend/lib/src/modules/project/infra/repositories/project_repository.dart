import 'package:backend/src/core/services/bcrypt_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/project_entity.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/project_repository.dart';
import '../../domain/usecases/update_projects.dart';
import '../adapters/project_adapter.dart';
import '../datasources/project_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDatasource datasource;
  final BCryptService bCryptService;

  ProjectRepositoryImpl(this.datasource, this.bCryptService);

  @override
  Future<Either<ProjectException, ProjectEntity>> createProject(ProjectEntity parameters) async {
    try {
      var userCreation = <String, dynamic>{
        'title': parameters.title,
        'description': parameters.description,
        'imageUrl': parameters.imageUrl,
        'active': parameters.active,
      };

      final projectMap = await datasource.createProject(userCreation);
      return Right(ProjectAdapter.fromJson(projectMap));
    } on ProjectException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ProjectException, ProjectEntity>> updateProject(UpdateProjectParams params) async {
    try {
      final userMap = await datasource.updateProject(params.toMap());
      return Right(ProjectAdapter.fromJson(userMap));
    } on ProjectException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ProjectException, ProjectEntity>> getProjectById(int id) async {
    try {
      final userMap = await datasource.getProjectById(id);
      return Right(ProjectAdapter.fromJson(userMap));
    } on ProjectException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ProjectException, List<ProjectEntity>>> getProjects() async {
    try {
      final result = await datasource.getProjects();
      final users = result.map(ProjectAdapter.fromJson).toList();
      return Right(users);
    } on ProjectException catch (e) {
      return Left(e);
    }
  }
}
