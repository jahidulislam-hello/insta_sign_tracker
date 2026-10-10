import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


/// White rounded "card" wrapper each screen sits inside.
class PanelCard extends StatelessWidget {
  final Widget child;
  const PanelCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Small pill showing e.g. "Total: 4".
class TotalBadge extends StatelessWidget {
  final int total;
  const TotalBadge({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.totalBadgeBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$total',
        style: const TextStyle(
          color: AppColors.totalBadgeText,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}

/// Colored chip used for Sign Type / Category values in table rows.
class ColorChip extends StatelessWidget {
  final String label;
  final BadgeColor color;
  const ColorChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color.text,
          fontWeight: FontWeight.w600,
          fontSize: 12.5,
        ),
      ),
    );
  }
}

/// The header row: "<Title>  Total: N" ... [optional filter] [search] [Add button]
class ListHeader extends StatelessWidget {
  final String title;
  final int total;
  final String addLabel;
  final VoidCallback onAdd;
  final ValueChanged<String> onSearchChanged;
  final Widget? filterWidget;

  const ListHeader({
    super.key,
    required this.title,
    required this.total,
    required this.addLabel,
    required this.onAdd,
    required this.onSearchChanged,
    this.filterWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      child: LayoutBuilder(builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 720;
        final titleRow = Row(
          children: [
            Text(title, style: AppTextStyles.pageTitle),
            TotalBadge(total: total),
          ],
        );

        final controlsRow = Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (filterWidget != null) ...[
              filterWidget!,
              const SizedBox(width: 12),
            ],
            Expanded(child: _SearchField(onChanged: onSearchChanged)),
            const SizedBox(width: 12),
            _AddButton(label: addLabel, onPressed: onAdd),
          ],
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleRow,
              const SizedBox(height: 14),
              controlsRow,
            ],
          );
        }

        return Row(
          children: [
            titleRow,
            const Spacer(),
            SizedBox(
              width: filterWidget != null ? 560 : 380,
              child: controlsRow,
            ),
          ],
        );
      }),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.searchFieldBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, size: 20, color: AppColors.textMuted),
          hintText: 'Search here...',
          hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _AddButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add, size: 18),
        label: Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

/// Table-like column header row.
class TableHeaderRow extends StatelessWidget {
  final List<TableColumnSpec> columns;
  const TableHeaderRow({super.key, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF7FAFE),
        border: Border(
          top: BorderSide(color: AppColors.border),
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        children: columns
            .map((c) => Expanded(
                  flex: c.flex,
                  child: Text(c.label, style: AppTextStyles.columnHeader),
                ))
            .toList(),
      ),
    );
  }
}

class TableColumnSpec {
  final String label;
  final int flex;
  const TableColumnSpec(this.label, {this.flex = 1});
}

/// A single data row with a bottom divider.
class TableDataRow extends StatelessWidget {
  final List<Widget> cells;
  final List<int> flexes;
  const TableDataRow({super.key, required this.cells, required this.flexes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: List.generate(cells.length, (i) {
          return Expanded(
            flex: flexes[i],
            child: Align(alignment: Alignment.centerLeft, child: cells[i]),
          );
        }),
      ),
    );
  }
}

/// Green edit pencil + red trash icons used in the Action column.
class RowActions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const RowActions({super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _IconButton(
          icon: Icons.edit_outlined,
          color: AppColors.editGreen,
          onTap: onEdit,
        ),
        const SizedBox(width: 14),
        _IconButton(
          icon: Icons.delete_outline,
          color: AppColors.deleteRed,
          onTap: onDelete,
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _IconButton(
      {required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(icon, size: 19, color: color),
      ),
    );
  }
}

/// Empty state shown when a search yields nothing / list is empty.
class EmptyRow extends StatelessWidget {
  final String message;
  const EmptyRow({super.key, this.message = 'No records found'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Text(message,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// Dialog shell + form fields
// -------------------------------------------------------------------------

/// Wraps every Add/Edit popup so they all share the same pixel layout:
/// title + close (X), fields, then Close / primary action buttons.
class FormDialogShell extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;

  const FormDialogShell({
    super.key,
    required this.title,
    required this.fields,
    required this.onPrimaryPressed,
    this.primaryLabel = 'Add',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 380,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 22),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: AppTextStyles.dialogTitle)),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close,
                      size: 20, color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ...fields,
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      side: const BorderSide(color: AppColors.border),
                      backgroundColor: AppColors.searchFieldBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Close',
                        style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPrimaryPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(primaryLabel,
                        style:
                            const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A labeled text field matching the flat gray-field look of the mockups.
class LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const LabeledField({
    super.key,
    required this.label,
    required this.controller,
    this.hint = '',
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.fieldLabel),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle:
                  const TextStyle(color: AppColors.textMuted, fontSize: 14),
              filled: true,
              fillColor: AppColors.searchFieldBg,
              suffixIcon: suffixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A labeled dropdown matching the same flat field look.
class LabeledDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final String hint;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  const LabeledDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint = 'Select an option',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.fieldLabel),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: AppColors.searchFieldBg,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                hint: Text(hint,
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 14)),
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary),
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
