import 'package:backend/src/modules/project/domain/entities/project_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../project/infra/adapters/project_adapter.dart';
import '../../user/domain/entities/user_entity.dart';
import '../../user/domain/errors/errors.dart';
import '../../user/infra/adapters/user_adapter.dart';
import 'user_on_project_datasource.dart';
import 'user_on_project_repository_interface.dart';

class UserOnProjectRepositoryImpl implements UserOnProjectRepository {
  final UserOnProjectDatasource datasource;

  UserOnProjectRepositoryImpl(this.datasource);

  @override
  Future<Either<UserException, List<UserEntity>>> getUsersByProjectId(int projectId) async {
    try {
      final result = await datasource.getUsersByProjectId(projectId);
      final users = result.map(UserAdapter.fromJson).toList();
      return Right(users);
    } on UserException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<UserException, List<ProjectEntity>>> getProjectsByUserId(int userId) async {
    try {
      final result = await datasource.getProjectsByUserId(userId);
      final projects = result.map(ProjectAdapter.fromJson).toList();
      return Right(projects);
    } on UserException catch (e) {
      return Left(e);
    }
  }
}
