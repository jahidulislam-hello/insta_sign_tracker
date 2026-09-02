import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';

/// The "Title  Total: N   ...search...  + Add X" header row used by every
/// list screen (Categories, Purchase Orders, Add-On Services, ...).
class ListPageHeader extends StatelessWidget {
  final String title;
  final int? total;
  final String addLabel;
  final VoidCallback onAdd;
  final ValueChanged<String>? onSearch;
  final String searchHint;

  const ListPageHeader({
    super.key,
    required this.title,
    this.total,
    required this.addLabel,
    required this.onAdd,
    this.onSearch,
    this.searchHint = 'Search here...',
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final narrow = constraints.maxWidth < 640;
      final titleRow = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
          if (total != null) ...[
            const SizedBox(width: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Total: ', style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.blueBadgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('$total',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.blueLink)),
                ),
              ],
            ),
          ],
        ],
      );

      final searchBox = SizedBox(
        width: narrow ? double.infinity : 260,
        child: TextField(
          onChanged: onSearch,
          style: const TextStyle(fontSize: 13),
          decoration: inputDecoration(hint: searchHint).copyWith(
            fillColor: AppColors.searchFieldBg,
            prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textMuted),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
          ),
        ),
      );

      final addButton = ElevatedButton.icon(
        onPressed: onAdd,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.add, size: 18),
        label: Text(addLabel, style: const TextStyle(fontWeight: FontWeight.w600)),
      );

      if (narrow) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleRow,
            const SizedBox(height: 12),
            searchBox,
            const SizedBox(height: 10),
            SizedBox(width: double.infinity, child: addButton),
          ],
        );
      }

      return Row(
        children: [
          titleRow,
          const Spacer(),
          searchBox,
          const SizedBox(width: 12),
          addButton,
        ],
      );
    });
  }
}
