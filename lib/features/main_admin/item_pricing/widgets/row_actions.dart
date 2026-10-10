import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';

/// The green "edit" (pencil-in-box) + red "delete" (trash-in-box) action
/// pair used at the end of most table rows. Set [boxed] to false for the
/// plain grey-icon style used on the Service Categories screen.
class RowActions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool boxed;

  const RowActions({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.boxed = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!boxed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(onTap: onEdit, child: const Icon(Icons.edit_outlined, size: 17, color: AppColors.textSecondary)),
          const SizedBox(width: 14),
          InkWell(onTap: onDelete, child: const Icon(Icons.delete_outline, size: 17, color: AppColors.textSecondary)),
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _iconBox(icon: Icons.edit_outlined, color: AppColors.green, onTap: onEdit),
        const SizedBox(width: 8),
        _iconBox(icon: Icons.delete_outline, color: AppColors.red, onTap: onDelete),
      ],
    );
  }

  Widget _iconBox({required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 14, color: color),
      ),
    );
  }
}

/// Small rounded pill used for category badges ("Sign Post"), coupon
/// status ("active" / "expired" / "inactive"), etc.
class Pill extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  final bool dense;

  const Pill({super.key, required this.label, required this.bg, required this.fg, this.dense = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: dense ? 8 : 10, vertical: dense ? 3 : 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

/// Deterministic colour assignment so the same category name always gets
/// the same badge colour (mirrors "Sign Post" / "Main Panel" / "Rider
/// Panel" badges in Purchase Orders & Add-On Services).
class BadgeColors {
  BadgeColors._();

  static final List<List<Color>> palette = [
    const [AppColors.blueLight, AppColors.blueLink],
    [const Color(0xFFF1EBFB), AppColors.purple],
    const [AppColors.orangeLight, AppColors.orange],
    const [AppColors.greenLight, AppColors.green],
    const [AppColors.redLight, AppColors.red],
  ];

  static List<Color> forKey(String key, List<String> orderedKeys) {
    final index = orderedKeys.indexOf(key);
    if (index < 0) return palette[0];
    return palette[index % palette.length];
  }
}
