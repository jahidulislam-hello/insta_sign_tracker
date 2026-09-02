import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/labeled_dropdown.dart';

enum RowStatus { assigned, pending, inProgress }

class MediaCount {
  final IconData icon;
  final String label;
  final int count;
  const MediaCount(this.icon, this.label, this.count);
}

class TaskTag {
  final String label;
  final Color bg;
  final Color fg;
  const TaskTag(this.label, this.bg, this.fg);
}

class TaskRow {
  final RowStatus status;
  final String address;
  final String client;
  final String taskName;
  final TaskTag? tag;
  final String dueDate;
  final String shotBy;
  final String editor;
  final double listingPrice;
  final String? noteLabel; // null => "+ Add Note"
  final List<MediaCount> media;
  final bool hasActions;

  const TaskRow({
    required this.status,
    required this.address,
    required this.client,
    required this.taskName,
    this.tag,
    required this.dueDate,
    required this.shotBy,
    required this.editor,
    required this.listingPrice,
    this.noteLabel,
    required this.media,
    this.hasActions = false,
  });
}

class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({super.key});

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  final List<TaskRow> _tasks = [
    TaskRow(
      status: RowStatus.assigned,
      address: '2100 Diller Rd, Elida, OH 45807, USA',
      client: 'Craig Magrum',
      taskName: 'Edit HDR Photos',
      tag: const TaskTag('Urgent', Color(0xFFFDECEC), Color(0xFFE05353)),
      dueDate: 'May 6, 2022, 8:00:00 AM',
      shotBy: '—',
      editor: 'Eddie Editor',
      listingPrice: 250000,
      noteLabel: '1 Note',
      media: const [
        MediaCount(Icons.photo_library_outlined, 'Gallery', 15),
        MediaCount(Icons.videocam_outlined, 'Videos', 1),
        MediaCount(Icons.view_in_ar_outlined, '3D', 0),
        MediaCount(Icons.layers_outlined, 'Floor Plan', 0),
        MediaCount(Icons.insert_drive_file_outlined, 'Files', 0),
      ],
      hasActions: true,
    ),
    TaskRow(
      status: RowStatus.pending,
      address: '2100 Diller Rd, Elida, OH 45807, USA',
      client: 'John Doe',
      taskName: 'Edit HDR Photos',
      tag: const TaskTag('High Priority', Color(0xFFF1EBFB), Color(0xFF8355D6)),
      dueDate: 'Jun 8, 2022, 8:00:00 AM',
      shotBy: '—',
      editor: 'Eddie Editor',
      listingPrice: 12000,
      noteLabel: null,
      media: const [
        MediaCount(Icons.photo_library_outlined, 'Gallery', 0),
        MediaCount(Icons.videocam_outlined, 'Videos', 0),
        MediaCount(Icons.view_in_ar_outlined, '3D', 0),
        MediaCount(Icons.layers_outlined, 'Floor Plan', 0),
        MediaCount(Icons.insert_drive_file_outlined, 'Files', 0),
      ],
    ),
    TaskRow(
      status: RowStatus.inProgress,
      address: '2100 Diller Rd, Elida, OH 45807, USA',
      client: 'Craig Magrum',
      taskName: 'Edit HDR Photos',
      tag: const TaskTag('Urgent', Color(0xFFFDECEC), Color(0xFFE05353)),
      dueDate: 'Jun 16, 2022, 8:00:00 AM',
      shotBy: 'Craig Magrum',
      editor: 'Eddie Editor',
      listingPrice: 275000,
      noteLabel: null,
      media: const [
        MediaCount(Icons.photo_library_outlined, 'Gallery', 20),
        MediaCount(Icons.videocam_outlined, 'Videos', 1),
        MediaCount(Icons.view_in_ar_outlined, '3D', 0),
        MediaCount(Icons.layers_outlined, 'Floor Plan', 0),
        MediaCount(Icons.insert_drive_file_outlined, 'Files', 0),
      ],
      hasActions: true,
    ),
    TaskRow(
      status: RowStatus.pending,
      address: '2100 Diller Rd, Elida, OH 45807, USA',
      client: 'Craig Magrum',
      taskName: 'Edit HDR Photos',
      tag: const TaskTag('Normal', Color(0xFFEAF3FE), Color(0xFF2F80ED)),
      dueDate: 'Aug 1, 2022, 8:00:00 AM',
      shotBy: 'Craig Magrum',
      editor: 'Eddie Editor',
      listingPrice: 300000,
      noteLabel: null,
      media: const [
        MediaCount(Icons.photo_library_outlined, 'Gallery', 0),
        MediaCount(Icons.videocam_outlined, 'Videos', 0),
        MediaCount(Icons.view_in_ar_outlined, '3D', 0),
        MediaCount(Icons.layers_outlined, 'Floor Plan', 0),
        MediaCount(Icons.insert_drive_file_outlined, 'Files', 0),
      ],
    ),
  ];

  DateTime _date = DateTime(2025, 2, 14);
  String _status = 'Status';
  String _category = 'Task Category';
  String _tagFilter = 'Tag Filter';
  String _assignee = 'Assignee';

  int get _incomplete => _tasks.length;

  void _shiftDate(int days) => setState(() => _date = _date.add(Duration(days: days)));

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  String get _formattedDate =>
      '${_months[_date.month - 1]} ${_date.day}, ${_date.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Task Manager', style: AppText.title),
              const SizedBox(height: 16),
              _dateRow(),
              const SizedBox(height: 14),
              _filterRow(),
              const SizedBox(height: 18),
              _progressRow(),
              const SizedBox(height: 20),
              _sectionHeader(),
              const SizedBox(height: 14),
              Expanded(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(width: 1500, child: _table()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateRow() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(onTap: () => _shiftDate(-1), child: const Icon(Icons.chevron_left, size: 18, color: AppColors.textSecondary)),
              const SizedBox(width: 6),
              const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Text(_formattedDate, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
              const SizedBox(width: 6),
              InkWell(onTap: () => _shiftDate(1), child: const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary)),
            ],
          ),
        ),
        Text('You have $_incomplete incomplete tasks out of $_incomplete tasks',
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        const Spacer(),
        SizedBox(
          width: 220,
          child: TextField(
            style: const TextStyle(fontSize: 13),
            decoration: inputDecoration(hint: 'Search').copyWith(
              prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textMuted),
            ),
          ),
        ),
      ],
    );
  }

  Widget _filterRow() {
    return LayoutBuilder(builder: (context, constraints) {
      final narrow = constraints.maxWidth < 700;
      final dropdowns = [
        LabeledDropdown(
          value: _status,
          items: const ['Status', 'To Do', 'In Progress', 'Done'],
          onChanged: (v) => setState(() => _status = v!),
        ),
        LabeledDropdown(
          value: _category,
          items: const ['Task Category', 'Photo', 'Video', 'Floor Plan'],
          onChanged: (v) => setState(() => _category = v!),
        ),
        LabeledDropdown(
          value: _tagFilter,
          items: const ['Tag Filter', 'Urgent', 'High Priority', 'Normal'],
          onChanged: (v) => setState(() => _tagFilter = v!),
        ),
        LabeledDropdown(
          value: _assignee,
          items: const ['Assignee', 'Eddie Editor', 'Craig Magrum'],
          onChanged: (v) => setState(() => _assignee = v!),
        ),
      ];
      if (narrow) {
        return Column(
          children: [
            for (final d in dropdowns) ...[d, const SizedBox(height: 10)],
          ],
        );
      }
      return Row(
        children: [
          for (int i = 0; i < dropdowns.length; i++) ...[
            Expanded(child: dropdowns[i]),
            if (i != dropdowns.length - 1) const SizedBox(width: 12),
          ],
        ],
      );
    });
  }

  Widget _progressRow() {
    return Row(
      children: [
        const Text('0%', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.0,
              minHeight: 6,
              backgroundColor: const Color(0xFFECEDF0),
              valueColor: const AlwaysStoppedAnimation(AppColors.textPrimary),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text('Done', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _sectionHeader() {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F1F4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.camera_alt_outlined, size: 18, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Photography Workflow', style: AppText.fieldLabel),
            Text('${_tasks.length} tasks', style: AppText.bodyMuted),
          ],
        ),
      ],
    );
  }

  // ---- table ----
  static const double _wMedia = 240;
  static const double _wTask = 130;
  static const double _wTags = 110;
  static const double _wDue = 170;
  static const double _wShot = 110;
  static const double _wEditor = 120;
  static const double _wPrice = 100;
  static const double _wNotes = 100;
  static const double _wMediaCounts = 130;
  static const double _wActions = 90;

  Widget _table() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            SizedBox(width: _wMedia, child: Text('Media Title', style: AppText.columnHeader)),
            SizedBox(width: _wTask, child: Text('Task Name', style: AppText.columnHeader)),
            SizedBox(width: _wTags, child: Text('Tags', style: AppText.columnHeader)),
            SizedBox(width: _wDue, child: Text('Due Date', style: AppText.columnHeader)),
            SizedBox(width: _wShot, child: Text('Shot By', style: AppText.columnHeader)),
            SizedBox(width: _wEditor, child: Text('Editor', style: AppText.columnHeader)),
            SizedBox(width: _wPrice, child: Text('Listing Price', style: AppText.columnHeader)),
            SizedBox(width: _wNotes, child: Text('Notes', style: AppText.columnHeader)),
            SizedBox(width: _wMediaCounts, child: Text('Media', style: AppText.columnHeader)),
            SizedBox(width: _wActions, child: Text('Actions', style: AppText.columnHeader)),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: AppColors.border),
        for (final t in _tasks) ...[
          const SizedBox(height: 16),
          _row(t),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border),
        ],
      ],
    );
  }

  Widget _row(TaskRow t) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _wMedia,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(_statusIcon(t.status), size: 15, color: _statusColor(t.status)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.address, style: AppText.cell, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(t.client, style: const TextStyle(fontSize: 12, color: AppColors.blueLink)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: _wTask, child: Text(t.taskName, style: AppText.cell)),
        SizedBox(
          width: _wTags,
          child: t.tag == null
              ? const SizedBox.shrink()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: t.tag!.bg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(t.tag!.label,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: t.tag!.fg)),
                ),
        ),
        SizedBox(
          width: _wDue,
          child: Row(
            children: [
              Expanded(child: Text(t.dueDate, style: AppText.cell, overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 4),
              const Icon(Icons.edit_outlined, size: 13, color: AppColors.textMuted),
            ],
          ),
        ),
        SizedBox(width: _wShot, child: Text(t.shotBy, style: AppText.cell)),
        SizedBox(
          width: _wEditor,
          child: Row(
            children: [
              Flexible(child: Text(t.editor, style: AppText.cell, overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 4),
              const Icon(Icons.edit_outlined, size: 13, color: AppColors.textMuted),
            ],
          ),
        ),
        SizedBox(
          width: _wPrice,
          child: Text('\$${t.listingPrice.toStringAsFixed(2)}', style: AppText.cell),
        ),
        SizedBox(
          width: _wNotes,
          child: t.noteLabel != null
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.blueLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.description_outlined, size: 12, color: AppColors.blueLink),
                      const SizedBox(width: 4),
                      Text(t.noteLabel!, style: const TextStyle(fontSize: 11.5, color: AppColors.blueLink)),
                    ],
                  ),
                )
              : InkWell(
                  onTap: () {},
                  child: const Text('+ Add Note',
                      style: TextStyle(fontSize: 12.5, color: AppColors.blueLink)),
                ),
        ),
        SizedBox(
          width: _wMediaCounts,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final m in t.media) _mediaLine(m),
            ],
          ),
        ),
        SizedBox(
          width: _wActions,
          child: t.hasActions
              ? Row(
                  children: [
                    _smallActionIcon(Icons.folder_outlined),
                    const SizedBox(width: 6),
                    _smallActionIcon(Icons.description_outlined),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _mediaLine(MediaCount m) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(m.icon, size: 13, color: AppColors.textMuted),
          const SizedBox(width: 6),
          Expanded(child: Text(m.label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))),
          Text('${m.count}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _smallActionIcon(IconData icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.blueLink),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 13, color: AppColors.blueLink),
      ),
    );
  }

  IconData _statusIcon(RowStatus s) {
    switch (s) {
      case RowStatus.assigned:
        return Icons.person_outline;
      case RowStatus.pending:
        return Icons.schedule;
      case RowStatus.inProgress:
        return Icons.play_arrow;
    }
  }

  Color _statusColor(RowStatus s) {
    switch (s) {
      case RowStatus.assigned:
        return AppColors.blueLink;
      case RowStatus.pending:
        return AppColors.textMuted;
      case RowStatus.inProgress:
        return AppColors.orange;
    }
  }
}
