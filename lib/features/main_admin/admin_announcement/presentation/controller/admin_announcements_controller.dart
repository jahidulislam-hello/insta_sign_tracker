// admin_announcements_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/announcement_model.dart';
import '../widget/admin_accouncement_dialog_widget.dart';
import '../widget/admin_annoucement_delete_widget.dart';

class AdminAnnouncementsController extends GetxController {
  final RxList<AnnouncementModel> announcements = <AnnouncementModel>[
    AnnouncementModel(
      id: '1',
      title: 'Announcement-1',
      message:
      'We Will Be Operating With A Reduced Team On 24th December And December 31st Our Office Will Be Closed On December 25 And January 1st',
      createdAt: DateTime.now(),
    ),
    AnnouncementModel(
      id: '2',
      title: 'Announcement-2',
      message:
      'Please be informed that the system will undergo scheduled maintenance on Saturday from 10 PM to 2 AM. Services may be temporarily unavailable.',
      createdAt: DateTime(2026, 4, 10),
    ),
    AnnouncementModel(
      id: '3',
      title: 'Announcement-3',
      message:
      'We Will Be Operating With A Reduced Team On 24th December And December 31st Our Office Will Be Closed On December 25 And January 1st',
      createdAt: DateTime(2026, 4, 10),
    ),
    AnnouncementModel(
      id: '4',
      title: 'Announcement-4',
      message:
      'New policy updates have been issued. All admins are requested to review the updated guidelines in the admin portal before end of this week.',
      createdAt: DateTime(2026, 3, 15),
    ),
  ].obs;

  final titleController = TextEditingController();
  final messageController = TextEditingController();

  AnnouncementModel? _editingAnnouncement;

  @override
  void onClose() {
    titleController.dispose();
    messageController.dispose();
    super.onClose();
  }

  void openAddDialog() {
    _editingAnnouncement = null;
    titleController.clear();
    messageController.clear();
    Get.dialog(
      const AdminAnnouncementDialogWidget(),
      barrierDismissible: false,
    );
  }

  void openEditDialog(AnnouncementModel announcement) {
    _editingAnnouncement = announcement;
    titleController.text = announcement.title;
    messageController.text = announcement.message;
    Get.dialog(
      const AdminAnnouncementDialogWidget(),
      barrierDismissible: false,
    );
  }

  void openDeleteDialog(AnnouncementModel announcement) {
    Get.dialog(
      AdminDeleteAnnouncementDialog(announcement: announcement),
      barrierDismissible: false,
    );
  }

  void submitDialog() {
    final title = titleController.text.trim();
    final message = messageController.text.trim();
    if (title.isEmpty || message.isEmpty) return;

    if (_editingAnnouncement != null) {
      final index =
      announcements.indexWhere((a) => a.id == _editingAnnouncement!.id);
      if (index != -1) {
        announcements[index] = AnnouncementModel(
          id: _editingAnnouncement!.id,
          title: title,
          message: message,
          imageUrl: _editingAnnouncement!.imageUrl,
          createdAt: _editingAnnouncement!.createdAt,
        );
      }
    } else {
      announcements.add(AnnouncementModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        message: message,
        createdAt: DateTime.now(),
      ));
    }

    Get.back();
  }

  void deleteAnnouncement(AnnouncementModel announcement) {
    announcements.removeWhere((a) => a.id == announcement.id);
    Get.back();
  }

  bool get isEditing => _editingAnnouncement != null;

  Map<String, List<AnnouncementModel>> get groupedAnnouncements {
    final Map<String, List<AnnouncementModel>> grouped = {};
    for (final a in announcements) {
      final key = _formatDate(a.createdAt);
      grouped.putIfAbsent(key, () => []).add(a);
    }
    return grouped;
  }

  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}