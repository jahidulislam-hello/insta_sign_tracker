class CourseModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String? videoThumbnail;
  final String? fullDescription;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.videoThumbnail,
    this.fullDescription,
  });
}