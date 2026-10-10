import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


/// A bordered, rounded dropdown selector with an optional label above it —
/// matches the "Beginning of Day" / "End of Day" style selects and the
/// "All Photographers" style selects across the app.
class LabeledDropdown extends StatelessWidget {
  final String? label;
  final String? helperText;
  final String value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const LabeledDropdown({
    super.key,
    this.label,
    this.helperText,
    required this.value,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppText.fieldLabel),
          const SizedBox(height: 6),
        ],
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : null,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 6),
          Text(helperText!,
              style: const TextStyle(fontSize: 11.5, color: AppColors.blueLink)),
        ],
      ],
    );
  }
}
