abstract class ProjectDatasource {
  Future<dynamic> createProject(Map<String, dynamic> project);
  Future<dynamic> updateProject(Map<String, dynamic> project);
  Future<dynamic> getProjectById(int id);
  Future<List> getProjects();
}
