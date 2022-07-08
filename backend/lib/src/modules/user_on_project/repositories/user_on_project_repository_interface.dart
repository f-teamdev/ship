import 'package:backend/src/modules/project/domain/entities/project_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../user/domain/entities/user_entity.dart';
import '../../user/domain/errors/errors.dart';

abstract class UserOnProjectRepository {
  Future<Either<UserException, List<UserEntity>>> getUsersByProjectId(int projectId);
  Future<Either<UserException, List<ProjectEntity>>> getProjectsByUserId(int projectId);
}
