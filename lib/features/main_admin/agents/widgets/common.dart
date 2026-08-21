import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


/// Rounded gray text field with placeholder styling, matching "Type here.."
/// fields in the Add Agent / Add Filter popups.
class AppTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final IconData? prefixIcon;

  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppText.body,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
        filled: true,
        fillColor: AppColors.fieldFill,
        prefixIcon: prefixIcon == null
            ? null
            : Icon(prefixIcon, size: 18, color: AppColors.textMuted),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusMd),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// A "Select ..." style dropdown box matching Brokerage / Field / Condition
/// selectors.
class AppDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final IconData? prefixIcon;

  const AppDropdown({
    super.key,
    required this.hint,
    required this.items,
    this.value,
    this.onChanged,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(prefixIcon, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
              ],
              Text(hint,
                  style:
                      const TextStyle(color: AppColors.textMuted, fontSize: 13)),
            ],
          ),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textSecondary),
          style: AppText.body,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

/// Filled blue primary button e.g. "Create Agent", "Add", "Save & Apply Filter"
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusMd),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16),
            const SizedBox(width: 6),
          ],
          Text(label,
              style: const TextStyle(
                  fontSize: 13.5, fontWeight: FontWeight.w600)),
        ],
      ),
    );
    return expand ? SizedBox(width: double.infinity, child: child) : child;
  }
}

/// Outlined / plain secondary button e.g. "Close", "Save Filter"
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;
  final bool expand;

  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.outlined = true,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: outlined ? Colors.white : AppColors.fieldFill,
        foregroundColor: outlined ? AppColors.textPrimary : AppColors.blue,
        elevation: 0,
        side: outlined ? const BorderSide(color: AppColors.border) : null,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusMd),
        ),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
    );
    return expand ? SizedBox(width: double.infinity, child: child) : child;
  }
}

/// Small pill/chip, e.g. "New Client" tag or "CRM Grid" badge.
class Pill extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  final Color? borderColor;

  const Pill({
    super.key,
    required this.text,
    required this.background,
    required this.foreground,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}

/// Small circular icon-only button used for view/edit/delete row actions and
/// header icon buttons (grid, more, close).
class IconCircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final Color? background;

  const IconCircleButton({
    super.key,
    required this.icon,
    this.color = AppColors.textSecondary,
    this.onPressed,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

/// A labeled section used throughout the dialogs: bold-ish label + child.
class FieldBlock extends StatelessWidget {
  final String label;
  final Widget child;
  final bool required;

  const FieldBlock({
    super.key,
    required this.label,
    required this.child,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppText.fieldLabel,
            children: [
              TextSpan(text: label),
              if (required)
                const TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.red)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
