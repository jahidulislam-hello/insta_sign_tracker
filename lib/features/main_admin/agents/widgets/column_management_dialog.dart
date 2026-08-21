import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'common.dart';

class _ColumnItem {
  final String label;
  bool checked;
  _ColumnItem(this.label, {this.checked = false});
}

class _ColumnSection {
  final String title;
  final Color badgeColor;
  final Color badgeBg;
  final List<_ColumnItem> items;
  _ColumnSection(this.title, this.badgeColor, this.badgeBg, this.items);
}

/// Pixel-matched "Column Management" popup (Image 5).
/// Opened from the grid icon button on the Agents screen toolbar.
class ColumnManagementDialog extends StatefulWidget {
  const ColumnManagementDialog({super.key});

  @override
  State<ColumnManagementDialog> createState() =>
      _ColumnManagementDialogState();
}

class _ColumnManagementDialogState extends State<ColumnManagementDialog> {
  bool _expanded = true;
  final _search = TextEditingController();

  late final _ColumnItem _contactNote = _ColumnItem('Contact Note', checked: true);

  late final List<_ColumnSection> _sections = [
    _ColumnSection(
      'ORDERS',
      AppColors.red,
      AppColors.redLight,
      [
        _ColumnItem('First Order Date'),
        _ColumnItem('Last Delivery Email Sent Date'),
        _ColumnItem('Last Order Date'),
      ],
    ),
    _ColumnSection(
      'REFERRAL',
      AppColors.red,
      AppColors.redLight,
      [
        _ColumnItem('Referral Code'),
        _ColumnItem('Referred Agents By Code'),
        _ColumnItem('Referred Amount Earned'),
      ],
    ),
  ];

  int get _selectedCount {
    var count = _contactNote.checked ? 1 : 0;
    for (final s in _sections) {
      count += s.items.where((i) => i.checked).length;
    }
    return count;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 380 ? screenWidth - 32 : 300.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.topRight,
      insetPadding: const EdgeInsets.only(top: 70, right: 16, left: 16, bottom: 24),
      child: Container(
        width: dialogWidth,
        constraints: const BoxConstraints(maxHeight: 460),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
          boxShadow: const [
            BoxShadow(color: Color(0x22000000), blurRadius: 24, offset: Offset(0, 8)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Column Management',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  IconCircleButton(
                    icon: _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    onPressed: () => setState(() => _expanded = !_expanded),
                  ),
                ],
              ),
            ),
            if (_expanded) ...[
              const Divider(height: 1, color: AppColors.border),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(hint: 'Search columns', controller: _search, prefixIcon: Icons.search),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _radioBox(false, onTap: () {}),
                              const SizedBox(width: 10),
                              const Text('Select All',
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Text('$_selectedCount selected',
                              style: AppText.bodyMuted),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _checkRow(
                        _contactNote.label,
                        _contactNote.checked,
                        highlighted: true,
                        onTap: () =>
                            setState(() => _contactNote.checked = !_contactNote.checked),
                      ),
                      for (final section in _sections) ...[
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Text(section.title, style: AppText.sectionLabel),
                            const SizedBox(width: 8),
                            Pill(
                              text: section.title[0] + section.title.substring(1).toLowerCase(),
                              background: section.badgeBg,
                              foreground: section.badgeColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        for (final item in section.items)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _radioRow(
                              item.label,
                              item.checked,
                              onTap: () => setState(() => item.checked = !item.checked),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _contactNote.checked = true;
                          for (final s in _sections) {
                            for (final i in s.items) {
                              i.checked = false;
                            }
                          }
                        });
                      },
                      child: const Text('Default Columns',
                          style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                    PrimaryButton(
                      label: 'Apply',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _radioBox(bool selected, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
      ),
    );
  }

  Widget _checkRow(String label, bool checked,
      {required VoidCallback onTap, bool highlighted = false}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: checked,
              activeColor: AppColors.blue,
              onChanged: (_) => onTap(),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: highlighted ? AppColors.blue : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _radioRow(String label, bool selected, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          _radioBox(selected, onTap: onTap),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: AppText.body)),
        ],
      ),
    );
  }
}
