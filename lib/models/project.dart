class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final bool isFeatured;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.isFeatured = false,
  });
}
