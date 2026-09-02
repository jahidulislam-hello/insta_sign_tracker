import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


/// Rounded gray text field with "Type here.." style placeholder.
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
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// A "Select ..." dropdown box matching the Brokerage selector.
class AppDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  const AppDropdown({
    super.key,
    required this.hint,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(AppColors.radiusLg),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(hint,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
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

/// Filled blue primary button e.g. "Add", "Save Changes", "Add Assistant".
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;
  final Color color;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.expand = false,
    this.color = AppColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    final child = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
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

/// Plain gray "Close" / "No" style secondary button.
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool expand;
  final Color textColor;

  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expand = false,
    this.textColor = AppColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    final child = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.fieldFill,
        foregroundColor: textColor,
        elevation: 0,
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

/// Small pill/badge, e.g. "Total: 3" or "NEW".
class Pill extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;

  const Pill({
    super.key,
    required this.text,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
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

/// Small circular icon-only button, e.g. row action icons and dialog close (X).
class IconCircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final Color? background;
  final double size;

  const IconCircleButton({
    super.key,
    required this.icon,
    this.color = AppColors.textSecondary,
    this.onPressed,
    this.background,
    this.size = 18,
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
        child: Icon(icon, size: size, color: color),
      ),
    );
  }
}

/// Labeled field block used across the Add/Edit Office dialogs.
class FieldBlock extends StatelessWidget {
  final String label;
  final Widget child;

  const FieldBlock({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.fieldLabel),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

/// Rounded bordered icon avatar used in the Create Order list rows.
class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color iconColor;

  const ServiceIcon({
    super.key,
    required this.icon,
    required this.background,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, size: 17, color: iconColor),
    );
  }
}
