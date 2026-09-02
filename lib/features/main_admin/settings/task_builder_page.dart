
import 'package:flutter/material.dart';
enum AssigneeKind { initials, icon }

class Assignee {
  final AssigneeKind kind;
  final String? initials;
  final IconData? icon;
  final Color bgColor;
  final Color fgColor;

  const Assignee.initials(this.initials, this.bgColor, this.fgColor)
      : kind = AssigneeKind.initials,
        icon = null;

  const Assignee.icon(this.icon, this.bgColor, this.fgColor)
      : kind = AssigneeKind.icon,
        initials = null;
}

class TaskItem {
  String name;
  String type; // Job / Service
  Assignee assignee;
  bool active;

  // Extra Task Setup fields
  String category;
  String instructions;
  String systemTaskOption;
  String dueDate;
  bool differentDueDate;
  String replaces;
  String assignedTo;

  TaskItem({
    required this.name,
    required this.type,
    required this.assignee,
    this.active = true,
    this.category = '',
    this.instructions = '',
    this.systemTaskOption = '',
    this.dueDate = '',
    this.differentDueDate = false,
    this.replaces = '',
    this.assignedTo = '',
  });
}

class TaskBuilderPage extends StatefulWidget {
  const TaskBuilderPage({super.key});

  @override
  State<TaskBuilderPage> createState() => _TaskBuilderPageState();
}

class _TaskBuilderPageState extends State<TaskBuilderPage> {
  final List<TaskItem> _tasks = [
    TaskItem(
        name: 'QC & Deliver',
        type: 'Job',
        assignee: const Assignee.initials('AO', Color(0xFFDDF3E4), Color(0xFF1E8A4C))),
    TaskItem(
        name: 'E-Soft Edit & Upload HDR Photos',
        type: 'Service',
        assignee: const Assignee.icon(Icons.star, Color(0xFFFFF1D6), Color(0xFFF5A623))),
    TaskItem(
        name: 'QC Photo and Deliver Media',
        type: 'Job',
        assignee: const Assignee.initials('AO', Color(0xFFDDF3E4), Color(0xFF1E8A4C))),
    TaskItem(
        name: 'Edit HDR Photos',
        type: 'Job',
        assignee: const Assignee.initials('AT', Color(0xFF7A1F1F), Colors.white)),
    TaskItem(
        name: 'Merge Fleet Video Editing',
        type: 'Service',
        assignee: const Assignee.icon(Icons.videocam, Color(0xFFEDEDED), Color(0xFF6B7280))),
    TaskItem(
        name: 'Edit HDR Photos',
        type: 'Job',
        assignee: const Assignee.initials('AT', Color(0xFF7A1F1F), Colors.white)),
    TaskItem(
        name: 'E-Soft Video Edit',
        type: 'Service',
        assignee: const Assignee.icon(Icons.star, Color(0xFFFFF1D6), Color(0xFFF5A623))),
    TaskItem(
        name: 'After Shoot Follow Up Automatic Email',
        type: 'Job',
        assignee: const Assignee.icon(Icons.mail_outline, Color(0xFFEDEDED), Color(0xFF6B7280))),
    TaskItem(
        name: 'QC & Deliver Media',
        type: 'Job',
        assignee: const Assignee.initials('BP', Color(0xFFFBD9EC), Color(0xFFD6337B))),
    TaskItem(
        name: 'E-Soft Floorplan Edit',
        type: 'Service',
        assignee: const Assignee.icon(Icons.star, Color(0xFFFFF1D6), Color(0xFFF5A623))),
    TaskItem(
        name: 'Edit HDR Images',
        type: 'Job',
        assignee: const Assignee.initials('AO', Color(0xFFDDF3E4), Color(0xFF1E8A4C))),
    TaskItem(
        name: 'Edit HDR Photos',
        type: 'Service',
        assignee: const Assignee.initials('AT', Color(0xFF7A1F1F), Colors.white)),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  List<TaskItem> get _filtered => _query.isEmpty
      ? _tasks
      : _tasks.where((t) => t.name.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openCreateDialog() async {
    final result = await showDialog<TaskItem>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const TaskSetupDialog(isEdit: false),
    );
    if (result != null) {
      setState(() => _tasks.add(result));
    }
  }

  Future<void> _openEditDialog(TaskItem task) async {
    final result = await showDialog<TaskItem>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => TaskSetupDialog(isEdit: true, existing: task),
    );
    if (result != null) {
      setState(() {
        task.name = result.name;
        task.category = result.category;
        task.type = result.type;
        task.instructions = result.instructions;
        task.systemTaskOption = result.systemTaskOption;
        task.dueDate = result.dueDate;
        task.differentDueDate = result.differentDueDate;
        task.replaces = result.replaces;
        task.assignedTo = result.assignedTo;
      });
    }
  }

  void _deleteTask(TaskItem task) {
    setState(() => _tasks.remove(task));
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
              _buildHeaderTitle(),
              const SizedBox(height: 16),
              _buildToolbar(),
              const SizedBox(height: 20),
              _buildTableHeader(),
              const Divider(height: 1, color: Color(0xFFEDEDED)),
              Expanded(
                child: ListView.separated(
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Color(0xFFF2F2F2)),
                  itemBuilder: (context, index) => _buildRow(_filtered[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return const Row(
      children: [
        Text(
          'Task Builder',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
        ),
        SizedBox(width: 8),
        CircleAvatar(radius: 4, backgroundColor: Color(0xFF2F9BFF)),
      ],
    );
  }

  Widget _buildToolbar() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: _openCreateDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F9BFF),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Create New',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 14),
        Text('You have ${_tasks.length} tasks',
            style: const TextStyle(fontSize: 13, color: Color(0xFF2F9BFF))),
        const Spacer(),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF2F9BFF),
            side: const BorderSide(color: Color(0xFFE5E7EB)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Refresh Orders',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 220,
          height: 42,
          child: TextField(
            controller: _searchController,
            onChanged: (v) => setState(() => _query = v),
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFF9CA3AF)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF2F9BFF)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const [
          Expanded(
            flex: 4,
            child: Text('Task Name',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF))),
          ),
          Expanded(
            flex: 2,
            child: Text('Task Type',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF))),
          ),
          SizedBox(
            width: 90,
            child: Text('Assignee',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF))),
          ),
          SizedBox(
            width: 80,
            child: Text('Active',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF))),
          ),
          SizedBox(
            width: 90,
            child: Text('Actions',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF))),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(TaskItem task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(task.name,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2F6FED))),
          ),
          Expanded(
            flex: 2,
            child: Text(task.type,
                style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
          ),
          SizedBox(
            width: 90,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: task.assignee.bgColor,
                  child: task.assignee.kind == AssigneeKind.initials
                      ? Text(task.assignee.initials!,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: task.assignee.fgColor))
                      : Icon(task.assignee.icon, size: 15, color: task.assignee.fgColor),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            child: Transform.scale(
              scale: 0.85,
              alignment: Alignment.centerLeft,
              child: Switch(
                value: task.active,
                onChanged: (v) => setState(() => task.active = v),
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF2F9BFF),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xFFD1D5DB),
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Row(
              children: [
                InkWell(
                  onTap: () => _openEditDialog(task),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.edit_outlined, size: 18, color: Color(0xFF2F9BFF)),
                  ),
                ),
                InkWell(
                  onTap: () => _deleteTask(task),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.delete_outline, size: 18, color: Color(0xFFEF4444)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Task Setup Dialog (shared for Create New -> Edit, driven by isEdit)
// =====================================================================

class TaskSetupDialog extends StatefulWidget {
  final bool isEdit;
  final TaskItem? existing;

  const TaskSetupDialog({super.key, required this.isEdit, this.existing});

  @override
  State<TaskSetupDialog> createState() => _TaskSetupDialogState();
}

class _TaskSetupDialogState extends State<TaskSetupDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _instructionsController;

  String? _category;
  String? _taskType;
  String? _systemTaskOption;
  String? _dueDate;
  bool _differentDueDate = false;
  String? _replaces;
  String? _assignedTo;

  final List<String> _categories = ['Editing', 'Delivery', 'Quality Control', 'Communication'];
  final List<String> _taskTypes = ['Job', 'Service'];
  final List<String> _systemOptions = ['None', 'Auto-assign', 'Notify client'];
  final List<String> _dueDateOptions = ['Same day', '1 day after order', '2 days after order'];
  final List<String> _replacesOptions = ['None', 'QC & Deliver', 'Edit HDR Photos'];
  final List<String> _assignedToOptions = ['Specific editor', 'Any available editor', 'Team lead'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existing?.name ?? '');
    _instructionsController = TextEditingController(text: widget.existing?.instructions ?? '');
    _category = (widget.existing?.category.isNotEmpty ?? false) ? widget.existing!.category : null;
    _taskType = (widget.existing?.type.isNotEmpty ?? false) ? widget.existing!.type : null;
    _systemTaskOption =
    (widget.existing?.systemTaskOption.isNotEmpty ?? false) ? widget.existing!.systemTaskOption : null;
    _dueDate = (widget.existing?.dueDate.isNotEmpty ?? false) ? widget.existing!.dueDate : null;
    _differentDueDate = widget.existing?.differentDueDate ?? false;
    _replaces = (widget.existing?.replaces.isNotEmpty ?? false) ? widget.existing!.replaces : null;
    _assignedTo = (widget.existing?.assignedTo.isNotEmpty ?? false) ? widget.existing!.assignedTo : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Task Setup';
    final actionLabel = widget.isEdit ? 'Update' : 'Create';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(vertical: 24),
      child: Container(
        width: 480,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, size: 20, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEDEDED)),
            // Scrollable body
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Task Name', required: true),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(fontSize: 14),
                      decoration: _fieldDecoration('Edit HDR Photos'),
                    ),
                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _labelWithHelp('Task Category', required: true),
                              const SizedBox(height: 8),
                              _buildDropdown(_categories, _category, 'Select',
                                      (v) => setState(() => _category = v)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _labelWithHelp('Task Type', required: true),
                              const SizedBox(height: 8),
                              _buildDropdown(_taskTypes, _taskType, 'Select Job',
                                      (v) => setState(() => _taskType = v)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    _labelWithHelp('Task Instructions'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _instructionsController,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 14),
                      decoration: _fieldDecoration('Provide detailed instructions for the editor'),
                    ),
                    const SizedBox(height: 18),

                    _labelWithHelp('System Task Options'),
                    const SizedBox(height: 8),
                    _buildDropdown(_systemOptions, _systemTaskOption, 'Select',
                            (v) => setState(() => _systemTaskOption = v)),
                    const SizedBox(height: 20),

                    _sectionCard(
                      title: 'Due Date',
                      children: [
                        _label('Select', required: true),
                        const SizedBox(height: 8),
                        _buildDropdown(_dueDateOptions, _dueDate, 'Select',
                                (v) => setState(() => _dueDate = v)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Switch(
                              value: _differentDueDate,
                              onChanged: (v) => setState(() => _differentDueDate = v),
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFF1F2937),
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: const Color(0xFFD1D5DB),
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text(
                                'I need to define a different due date if a certain service is ordered',
                                style: TextStyle(fontSize: 13, color: Color(0xFF2F9BFF)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _sectionCard(
                      title: 'Replaces',
                      children: [
                        _label('Select Task it can replaced'),
                        const SizedBox(height: 8),
                        _buildDropdown(_replacesOptions, _replaces, 'Select',
                                (v) => setState(() => _replaces = v)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _sectionCard(
                      title: 'Assigned To',
                      children: [
                        _label('Type of assignment'),
                        const SizedBox(height: 8),
                        _buildDropdown(_assignedToOptions, _assignedTo, 'Select',
                                (v) => setState(() => _assignedTo = v)),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEDEDED)),
            // Footer
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF374151),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Close',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.trim().isEmpty) return;
                      Navigator.of(context).pop(
                        TaskItem(
                          name: _nameController.text.trim(),
                          type: _taskType ?? 'Job',
                          assignee: widget.existing?.assignee ??
                              const Assignee.initials('AO', Color(0xFFDDF3E4), Color(0xFF1E8A4C)),
                          active: widget.existing?.active ?? true,
                          category: _category ?? '',
                          instructions: _instructionsController.text.trim(),
                          systemTaskOption: _systemTaskOption ?? '',
                          dueDate: _dueDate ?? '',
                          differentDueDate: _differentDueDate,
                          replaces: _replaces ?? '',
                          assignedTo: _assignedTo ?? '',
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F9BFF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(actionLabel,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text, {bool required = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
        children: required
            ? const [
          TextSpan(text: ' *', style: TextStyle(color: Color(0xFFEF4444))),
        ]
            : [],
      ),
    );
  }

  Widget _labelWithHelp(String text, {bool required = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _label(text, required: required),
        const SizedBox(width: 4),
        const Icon(Icons.help_outline, size: 14, color: Color(0xFF2F9BFF)),
      ],
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEDEDED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDropdown(
      List<String> options, String? value, String hint, ValueChanged<String?> onChanged) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
          style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
          items: options
              .map((o) => DropdownMenuItem(value: o, child: Text(o)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFB0B4BA), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF7F8FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2F9BFF)),
      ),
    );
  }
}