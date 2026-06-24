// announcement_model.dart
class AnnouncementModel {
  final String id;
  final String title;
  final String message;
  final String? imageUrl;
  final DateTime createdAt;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.message,
    this.imageUrl,
    required this.createdAt,
  });
}