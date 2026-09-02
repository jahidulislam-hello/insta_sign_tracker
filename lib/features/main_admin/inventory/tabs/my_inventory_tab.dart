import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models.dart';

class MyInventoryTab extends StatelessWidget {
  final List<CategorySummary> categories;
  const MyInventoryTab({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inventory Distribution by Type', style: AppText.title),
        const SizedBox(height: 2),
        Text('Overview of all inventory categories', style: AppText.pageSubtitle),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            const gap = 16.0;
            final columns = constraints.maxWidth > 900 ? 3 : 1;
            final cardWidth =
                (constraints.maxWidth - gap * (columns - 1)) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: categories
                  .map((c) => SizedBox(
                        width: cardWidth,
                        child: _CategoryCard(category: c),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategorySummary category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category.title, style: AppText.cardTitle),
          Text('${category.itemTypes} items types', style: AppText.cardSubtitle),
          const SizedBox(height: 18),
          Row(
            children: [
              _stat('Total Units', '${category.totalUnits}', AppColors.textPrimary),
              const SizedBox(width: 24),
              _stat('In stock', '${category.inStock}', AppColors.blue),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _stat('Checked out', '${category.checkedOut}', AppColors.blue),
              const SizedBox(width: 24),
              _stat('Low stock', '${category.lowStock}', AppColors.coralRed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, Color valueColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.cardSubtitle),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700, color: valueColor)),
        ],
      ),
    );
  }
}
