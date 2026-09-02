import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'shared_controls.dart';

class ReasonEntry {
  final TextEditingController controller;
  bool active;
  ReasonEntry({required String text, this.active = true}) : controller = TextEditingController(text: text);
}

/// The "Add reasons for agents to select when..." editor: a list of
/// text-field rows each with an Active toggle + delete icon, a trailing
/// empty "Enter here" row with a "+" add button, an "Add 'Other' reason"
/// toggle, and a Save Changes button. Used identically by both the
/// Cancellation Reasons and Reschedule Reasons cards.
class ReasonListEditor extends StatefulWidget {
  final String introText;
  final List<String> initialReasons;

  const ReasonListEditor({super.key, required this.introText, required this.initialReasons});

  @override
  State<ReasonListEditor> createState() => _ReasonListEditorState();
}

class _ReasonListEditorState extends State<ReasonListEditor> {
  late final List<ReasonEntry> _reasons =
      widget.initialReasons.map((r) => ReasonEntry(text: r)).toList();
  final TextEditingController _newEntryController = TextEditingController();
  bool _newEntryActive = true;
  bool _addOtherReason = true;

  void _addReason() {
    final text = _newEntryController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _reasons.add(ReasonEntry(text: text, active: _newEntryActive));
      _newEntryController.clear();
      _newEntryActive = true;
    });
  }

  void _removeReason(ReasonEntry entry) {
    setState(() => _reasons.remove(entry));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.introText, style: AppText.body),
        const SizedBox(height: 14),
        for (final r in _reasons) ...[
          _reasonRow(
            controller: r.controller,
            active: r.active,
            onActiveChanged: (v) => setState(() => r.active = v),
            onDelete: () => _removeReason(r),
          ),
          const SizedBox(height: 10),
        ],
        _reasonRow(
          controller: _newEntryController,
          hint: 'Enter here',
          active: _newEntryActive,
          onActiveChanged: (v) => setState(() => _newEntryActive = v),
          isAddRow: true,
          onAdd: _addReason,
        ),
        const SizedBox(height: 14),
        ToggleRow(
          title: 'Add "Other" reason',
          value: _addOtherReason,
          onChanged: (v) => setState(() => _addOtherReason = v),
          backgroundColor: AppColors.panelFill,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        const SizedBox(height: 16),
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 16),
        SaveChangesButton(onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Changes saved'), duration: Duration(seconds: 1)),
          );
        }),
      ],
    );
  }

  Widget _reasonRow({
    required TextEditingController controller,
    String? hint,
    required bool active,
    required ValueChanged<bool> onActiveChanged,
    VoidCallback? onDelete,
    bool isAddRow = false,
    VoidCallback? onAdd,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 13, color: AppColors.blue, fontWeight: FontWeight.w600),
            decoration: boxedInputDecoration(hint: hint),
          ),
        ),
        const SizedBox(width: 12),
        const Text('Active', style: TextStyle(fontSize: 12.5, color: AppColors.textMuted)),
        Transform.scale(
          scale: 0.85,
          child: Switch(
            value: active,
            onChanged: onActiveChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.blue,
            inactiveThumbColor: AppColors.toggleOffTrack,
            inactiveTrackColor: const Color(0xFFE5E7EB),
          ),
        ),
        const SizedBox(width: 4),
        if (isAddRow)
          InkWell(
            onTap: onAdd,
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.blueLight,
                border: Border.all(color: AppColors.blue),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.add, size: 17, color: AppColors.blue),
            ),
          )
        else
          InkWell(
            onTap: onDelete,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.delete_outline, size: 18, color: AppColors.textSecondary),
            ),
          ),
      ],
    );
  }
}
