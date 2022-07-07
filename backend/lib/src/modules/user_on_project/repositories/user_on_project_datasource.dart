abstract class UserOnProjectDatasource {
  Future<List> getUsersByProjectId(int projectId);
  Future<List> getProjectsByUserId(int userId);
}
