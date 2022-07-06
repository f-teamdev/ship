import 'package:backend/src/core/services/bcrypt_service.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';
import 'package:backend/src/modules/user/infra/adapters/user_adapter.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/project_repository.dart';
import '../../domain/usecases/update_projects.dart';
import '../datasources/user_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final UserDatasource datasource;
  final BCryptService bCryptService;

  ProjectRepositoryImpl(this.datasource, this.bCryptService);

  @override
  Future<Either<UserException, ProjectEntity>> createProject(ProjectEntity parameters) async {
    try {
      var userCreation = <String, dynamic>{
        'title': parameters.title,
        'description': parameters.description,
        'imageUrl': parameters.imageUrl,
        'active': parameters.active,
      };

      final userMap = await datasource.createUser(userCreation);
      return Right(ProjectAdapter.fromJson(userMap));
    } on UserException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<UserException, ProjectEntity>> updateUser(UpdateProjectParams params) async {
    try {
      final userMap = await datasource.updateUser(params.toMap());
      return Right(ProjectAdapter.fromJson(userMap));
    } on UserException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<UserException, ProjectEntity>> getUserById(int id) async {
    try {
      final userMap = await datasource.getUserById(id);
      return Right(ProjectAdapter.fromJson(userMap));
    } on UserException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<UserException, List<ProjectEntity>>> getUsers() async {
    try {
      final result = await datasource.getUsers();
      final users = result.map(ProjectAdapter.fromJson).toList();
      return Right(users);
    } on UserException catch (e) {
      return Left(e);
    }
  }
}
