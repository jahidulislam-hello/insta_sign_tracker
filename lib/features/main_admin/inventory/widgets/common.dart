import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


/// The pill-style section switcher used at the top of every tab:
/// Table View | Agent | Office | Warehouse | My Inventory | Returns
class SectionTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const SectionTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: List.generate(tabs.length, (i) {
            final selected = i == selectedIndex;
            return GestureDetector(
              onTap: () => onChanged(i),
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: const EdgeInsets.only(right: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? AppColors.fieldFill : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppColors.radiusMd),
                ),
                child: Text(
                  tabs[i],
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? AppColors.textPrimary
                        : AppColors.textMuted,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Rounded status/category badge, e.g. "In Stock" (green) or "Out" (blue).
class StatusChip extends StatelessWidget {
  final String label;
  final BadgeColor colors;
  const StatusChip({super.key, required this.label, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: colors.text,
        ),
      ),
    );
  }
}

/// Small circular avatar placeholder (used for the agent icon).
class AgentAvatar extends StatelessWidget {
  final double size;
  const AgentAvatar({super.key, this.size = 28});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.lightPinkBg,
      child: Icon(Icons.person, size: size * 0.55, color: AppColors.pink),
    );
  }
}

/// A generic labeled search field used across tabs.
class InventorySearchField extends StatelessWidget {
  final String hint;
  const InventorySearchField({super.key, this.hint = 'Search...'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.searchFieldBg,
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
      ),
      child: TextField(
        style: AppText.body,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
          prefixIcon: const Icon(Icons.search,
              size: 20, color: AppColors.primaryBlue),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}

/// The small "All types" / "All Agents" filter buttons in the Table View
/// and Returns tabs.
class FilterButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  const FilterButton({
    super.key,
    required this.label,
    this.icon = Icons.filter_list,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppColors.radiusSm),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppColors.radiusSm),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: AppText.body),
            const SizedBox(width: 6),
            Icon(icon, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

/// Primary blue action button (Add Item / New Item / Add / etc.)
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  const PrimaryButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusSm),
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
  }
}

/// Secondary outlined button (Import / Export / Close)
class SecondaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  const SecondaryButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.radiusSm),
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
  }
}
