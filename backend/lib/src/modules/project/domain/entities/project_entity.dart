class ProjectEntity {
  final int id;
  final String title;
  final String description;
  final String? imageUrl;
  final bool active;

  ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.active,
    this.imageUrl,
  });
}
