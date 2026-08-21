import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'common.dart';

/// Pixel-matched "Add Filter" popup (Image 4).
/// Opened from the "+ Add Filter" action inside [FiltersPanel].
class AddFilterDialog extends StatefulWidget {
  const AddFilterDialog({super.key});

  @override
  State<AddFilterDialog> createState() => _AddFilterDialogState();
}

class _ConditionRow {
  String? field;
  String? condition;
  final TextEditingController value = TextEditingController();
}

class _AddFilterDialogState extends State<AddFilterDialog> {
  final List<_ConditionRow> _allConditions = [_ConditionRow()];
  final List<_ConditionRow> _anyConditions = [];
  final _filterName = TextEditingController();
  String _visibility = 'Private';
  bool _saveColumn = false;

  static const _fields = ['Name', 'Email', 'Brokerage', 'Tags', 'Last Contact Date'];
  static const _conditions = ['Equals', 'Not Equals', 'Contains', 'Is Empty', 'Is Not Empty'];

  @override
  void dispose() {
    _filterName.dispose();
    for (final c in [..._allConditions, ..._anyConditions]) {
      c.value.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final narrow = screenWidth < 640;
    final dialogWidth = narrow ? screenWidth - 32 : 640.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: dialogWidth,
        constraints: const BoxConstraints(maxHeight: 700),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Add Filter',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary)),
                  IconCircleButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _sectionLabel('Match ALL of the conditions'),
              const SizedBox(height: 10),
              _conditionBox(
                conditions: _allConditions,
                narrow: narrow,
                showWhere: true,
                onAdd: () => setState(() => _allConditions.add(_ConditionRow())),
              ),
              const SizedBox(height: 18),
              _sectionLabel('And Match ANY of the conditions'),
              const SizedBox(height: 10),
              _conditionBox(
                conditions: _anyConditions,
                narrow: narrow,
                showWhere: false,
                onAdd: () => setState(() => _anyConditions.add(_ConditionRow())),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(builder: (context, constraints) {
                final stackedFields = constraints.maxWidth < 420;
                final nameField = FieldBlock(
                  label: 'FILTER NAME',
                  required: true,
                  child: AppTextField(hint: 'Enter here', controller: _filterName),
                );
                final visibilityField = FieldBlock(
                  label: 'VISIBILITY',
                  child: AppDropdown<String>(
                    hint: 'Private',
                    prefixIcon: Icons.lock_outline,
                    value: _visibility,
                    items: const [
                      DropdownMenuItem(value: 'Private', child: Text('Private')),
                      DropdownMenuItem(value: 'Team', child: Text('Team')),
                      DropdownMenuItem(value: 'Public', child: Text('Public')),
                    ],
                    onChanged: (v) => setState(() => _visibility = v ?? 'Private'),
                  ),
                );
                if (stackedFields) {
                  return Column(
                    children: [
                      nameField,
                      const SizedBox(height: 14),
                      visibilityField,
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: nameField),
                    const SizedBox(width: 20),
                    Expanded(child: visibilityField),
                  ],
                );
              }),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: _saveColumn,
                      activeColor: AppColors.chipBlack,
                      onChanged: (v) => setState(() => _saveColumn = v ?? false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Save column with the filter', style: AppText.body),
                  const SizedBox(width: 4),
                  const Icon(Icons.info_outline,
                      size: 15, color: AppColors.textMuted),
                ],
              ),
              const SizedBox(height: 22),
              LayoutBuilder(builder: (context, constraints) {
                final stacked = constraints.maxWidth < 380;
                final saveBtn = SecondaryButton(
                  label: 'Save Filter',
                  expand: stacked,
                  onPressed: () => Navigator.of(context).pop(),
                );
                final applyBtn = PrimaryButton(
                  label: 'Save & Apply Filter',
                  expand: stacked,
                  onPressed: () => Navigator.of(context).pop(),
                );
                if (stacked) {
                  return Column(
                    children: [applyBtn, const SizedBox(height: 10), saveBtn],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    saveBtn,
                    const SizedBox(width: 12),
                    applyBtn,
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Row(
      children: [
        Text(text,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(width: 6),
        const Icon(Icons.info_outline, size: 14, color: AppColors.textMuted),
      ],
    );
  }

  Widget _conditionBox({
    required List<_ConditionRow> conditions,
    required bool narrow,
    required bool showWhere,
    required VoidCallback onAdd,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < conditions.length; i++) ...[
            _conditionRow(conditions[i], narrow, showWhere: showWhere && i == 0),
            if (i != conditions.length - 1) const SizedBox(height: 10),
          ],
          if (conditions.isNotEmpty) const SizedBox(height: 12),
          InkWell(
            onTap: onAdd,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 16, color: AppColors.blue),
                SizedBox(width: 6),
                Text('Add Condition',
                    style: TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _conditionRow(_ConditionRow row, bool narrow, {required bool showWhere}) {
    final wherePill = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.chipBlack,
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
      ),
      child: const Text('WHERE',
          style: TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
    );

    final fieldDropdown = AppDropdown<String>(
      hint: 'Select Field',
      value: row.field,
      items: _fields.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
      onChanged: (v) => setState(() => row.field = v),
    );
    final conditionDropdown = AppDropdown<String>(
      hint: 'Select Condition',
      value: row.condition,
      items: _conditions.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
      onChanged: (v) => setState(() => row.condition = v),
    );
    final valueField = AppTextField(hint: 'Value', controller: row.value);

    if (narrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showWhere) ...[wherePill, const SizedBox(height: 8)],
          fieldDropdown,
          const SizedBox(height: 8),
          conditionDropdown,
          const SizedBox(height: 8),
          valueField,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 74, child: showWhere ? wherePill : const SizedBox()),
        const SizedBox(width: 10),
        Expanded(child: fieldDropdown),
        const SizedBox(width: 10),
        Expanded(child: conditionDropdown),
        const SizedBox(width: 10),
        Expanded(child: valueField),
      ],
    );
  }
}
