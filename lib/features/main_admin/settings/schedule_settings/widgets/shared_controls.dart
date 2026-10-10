import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';

/// The bordered, radio-style selectable card used for "Manual" /
/// "Automatic Scheduling" and "Exact Arrival Time" / "2 Hour Arrival
/// Window". Highlights blue when [selected].
class SelectableOptionTile extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final String title;
  final String? description;
  final IconData? leadingIcon;
  final bool dense;

  const SelectableOptionTile({
    super.key,
    required this.selected,
    required this.onTap,
    required this.title,
    this.description,
    this.leadingIcon,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(dense ? 12 : 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.blueLight : Colors.white,
          border: Border.all(color: selected ? AppColors.blue : AppColors.border, width: selected ? 1.4 : 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: dense ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 18, color: selected ? AppColors.blue : AppColors.textMuted),
              const SizedBox(width: 10),
            ] else ...[
              _radio(),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: dense ? AppText.fieldLabel.copyWith(fontSize: 13) : AppText.optionTitle),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(description!, style: AppText.optionBody),
                  ],
                ],
              ),
            ),
            if (leadingIcon != null) ...[
              const SizedBox(width: 10),
              _radio(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _radio() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: selected ? AppColors.blue : AppColors.borderStrong, width: 1.6),
      ),
      child: selected
          ? Center(
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
              ),
            )
          : null,
    );
  }
}

/// The full-width blue "Save Changes" button used at the bottom of every
/// expanded card.
class SaveChangesButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const SaveChangesButton({super.key, required this.onPressed, this.label = 'Save Changes'});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

/// A labeled bordered dropdown selector, reused across cards.
class LabeledDropdown extends StatelessWidget {
  final String? label;
  final String value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final bool enabled;

  const LabeledDropdown({
    super.key,
    this.label,
    required this.value,
    required this.items,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppText.fieldLabel),
          const SizedBox(height: 8),
        ],
        Opacity(
          opacity: enabled ? 1 : 0.5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: items.contains(value) ? value : null,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
                style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: enabled ? onChanged : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// A toggle row: bold (optionally colored) label + description on the
/// left, a Switch on the right. Reused by every "Toggle X" setting.
class ToggleRow extends StatelessWidget {
  final String title;
  final String? description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? titleColor;
  final Color activeTrackColor;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  const ToggleRow({
    super.key,
    required this.title,
    this.description,
    required this.value,
    required this.onChanged,
    this.titleColor,
    this.activeTrackColor = AppColors.blue,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: activeTrackColor,
            inactiveThumbColor: AppColors.toggleOffTrack,
            inactiveTrackColor: const Color(0xFFE5E7EB),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.fieldLabel.copyWith(color: titleColor ?? AppColors.textPrimary)),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(description!, style: AppText.body),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
    if (backgroundColor == null) return content;
    return DecoratedBox(
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
      child: content,
    );
  }
}
