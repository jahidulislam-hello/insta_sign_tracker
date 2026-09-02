
import 'dart:typed_data';
import 'package:flutter/material.dart';


class Announcement {
  String title;
  String message;
  Uint8List? imageBytes;

  Announcement({required this.title, required this.message, this.imageBytes});
}

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  final List<Announcement> _announcements = [
    Announcement(
      title: 'Announcement-1',
      message:
      'We Will Be Operating With A Reduced Team On 24th December And December 31st Our Office Will Be Closed On December 25 And January 1st',
    ),
    Announcement(
      title: 'Announcement-02',
      message:
      'We Will Be Operating With A Reduced Team On 24th December And December 31st Our Office Will Be Closed On December 25 And January 1st',
    ),
  ];

  Future<void> _openCreateDialog() async {
    final result = await showDialog<Announcement>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const AnnouncementDialog(isEdit: false),
    );
    if (result != null) {
      setState(() => _announcements.add(result));
    }
  }

  Future<void> _openEditDialog(Announcement announcement) async {
    final result = await showDialog<Announcement>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => AnnouncementDialog(isEdit: true, existing: announcement),
    );
    if (result != null) {
      setState(() {
        announcement.title = result.title;
        announcement.message = result.message;
        announcement.imageBytes = result.imageBytes;
      });
    }
  }

  void _deleteAnnouncement(Announcement announcement) {
    setState(() => _announcements.remove(announcement));
  }

  void _viewAnnouncement(Announcement announcement) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 420,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(announcement.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, size: 20, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (announcement.imageBytes != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(announcement.imageBytes!, fit: BoxFit.cover),
                ),
                const SizedBox(height: 16),
              ],
              Text(announcement.message,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: _announcements.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) => _buildCard(_announcements[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Announcements',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F2937),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Send Updates And Important Notices To All Users Under Your Company.',
                style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: _openCreateDialog,
          icon: const Icon(Icons.add, size: 18, color: Colors.white),
          label: const Text(
            'Create Announcement',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F9BFF),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(Announcement announcement) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEDEDED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  announcement.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  announcement.message,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF), height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => _viewAnnouncement(announcement),
            borderRadius: BorderRadius.circular(4),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.remove_red_eye_outlined, size: 18, color: Color(0xFF9CA3AF)),
            ),
          ),
          InkWell(
            onTap: () => _openEditDialog(announcement),
            borderRadius: BorderRadius.circular(4),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.edit_outlined, size: 18, color: Color(0xFF22C55E)),
            ),
          ),
          InkWell(
            onTap: () => _deleteAnnouncement(announcement),
            borderRadius: BorderRadius.circular(4),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.delete_outline, size: 18, color: Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================================================
// Create / Edit Announcement Dialog (shared widget, driven by isEdit)
// =======================================================================

class AnnouncementDialog extends StatefulWidget {
  final bool isEdit;
  final Announcement? existing;

  const AnnouncementDialog({super.key, required this.isEdit, this.existing});

  @override
  State<AnnouncementDialog> createState() => _AnnouncementDialogState();
}

class _AnnouncementDialogState extends State<AnnouncementDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _messageController;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existing?.title ?? '');
    _messageController = TextEditingController(text: widget.existing?.message ?? '');
    _imageBytes = widget.existing?.imageBytes;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Placeholder for actual file picking (image_picker / file_picker package).
  Future<void> _pickImage() async {
    // Integrate file_picker or image_picker here to set _imageBytes.
    // Left as a stub since no image-picking package is wired up in this snippet.
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEdit ? 'Edit Announcement' : 'Create Announcement';
    final actionLabel = widget.isEdit ? 'Update' : 'Send';

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, size: 20, color: Color(0xFF6B7280)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Title field
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              autofocus: true,
              style: const TextStyle(fontSize: 14),
              decoration: _fieldDecoration('Type Here..'),
            ),
            const SizedBox(height: 18),

            // Upload image
            const Text(
              'Upload Image',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickImage,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: _imageBytes != null
                    ? Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.memory(_imageBytes!,
                          width: 28, height: 28, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 10),
                    const Text('Image selected',
                        style: TextStyle(fontSize: 14, color: Color(0xFF1F2937))),
                  ],
                )
                    : Row(
                  children: const [
                    Icon(Icons.file_upload_outlined, size: 18, color: Color(0xFF6B7280)),
                    SizedBox(width: 10),
                    Text('Upload',
                        style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Message field
            const Text(
              'Message',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              maxLines: 4,
              style: const TextStyle(fontSize: 14),
              decoration: _fieldDecoration('Type Here..'),
            ),
            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2F9BFF),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Close',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.trim().isEmpty) return;
                      Navigator.of(context).pop(
                        Announcement(
                          title: _titleController.text.trim(),
                          message: _messageController.text.trim(),
                          imageBytes: _imageBytes,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F9BFF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(actionLabel,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFB0B4BA), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF3F4F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}