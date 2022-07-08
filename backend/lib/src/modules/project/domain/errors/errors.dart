abstract class ProjectException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ProjectException(this.message, [this.stackTrace]);

  @override
  String toString() {
    return '$runtimeType: $message\n${stackTrace ?? ''}';
  }
}

class ProjectCreationValidate extends ProjectException {
  ProjectCreationValidate(super.message);
}

class ProjectUpdateValidate extends ProjectException {
  ProjectUpdateValidate(super.message);
}

class GetProjectValidate extends ProjectException {
  GetProjectValidate(super.message);
}

class ProjectNotFound extends ProjectException {
  ProjectNotFound(super.message);
}
