import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models.dart';

/// Shared by both the "Office" tab (screenshot 5) and the "Warehouse" tab
/// (screenshot 6) — same layout, different branch data and default-open
/// row.
class OfficeWarehouseTab extends StatefulWidget {
  final List<BranchSummary> branches;
  final bool firstExpanded;

  const OfficeWarehouseTab({
    super.key,
    required this.branches,
    this.firstExpanded = true,
  });

  @override
  State<OfficeWarehouseTab> createState() => _OfficeWarehouseTabState();
}

class _OfficeWarehouseTabState extends State<OfficeWarehouseTab> {
  late List<bool> expanded;

  @override
  void initState() {
    super.initState();
    expanded = List.generate(
      widget.branches.length,
          (i) => i == 0 ? widget.firstExpanded : false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inventory Distribution by Type', style: AppText.title),
        const SizedBox(height: 2),
        Text('Overview of all inventory categories', style: AppText.pageSubtitle),
        const SizedBox(height: 16),
        ...List.generate(widget.branches.length, (i) {
          final b = widget.branches[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: cardDecoration(),
            child: Column(
              children: [
                InkWell(
                  onTap: () => setState(() => expanded[i] = !expanded[i]),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _BranchHeader(
                      branch: b,
                      isExpanded: expanded[i],
                    ),
                  ),
                ),
                if (expanded[i])
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(AppColors.radiusSm),
                      ),
                      child: Text(
                        'Additional office details would be displayed here',
                        style: AppText.bodyMuted,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

/// The tappable header row for a single branch card. Pulled out into its
/// own widget (with a LayoutBuilder) so it can switch between a single-row
/// layout on wide screens and a stacked layout on narrow ones — this is
/// what fixes the RenderFlex overflow that happened when the stats +
/// chevron squeezed the manager/address column down to a few pixels.
class _BranchHeader extends StatelessWidget {
  final BranchSummary branch;
  final bool isExpanded;
  const _BranchHeader({required this.branch, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 560;

        final icon = Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.blueIconBg,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.apartment,
              size: 18, color: AppColors.primaryBlue),
        );

        final info = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(branch.name, style: AppText.cardTitle),
            const SizedBox(height: 3),
            Row(
              children: [
                const Icon(Icons.people_outline,
                    size: 13, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'Manager: ${branch.manager}',
                    style: AppText.cardSubtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 13, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    branch.address,
                    style: AppText.cardSubtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        );

        final stats = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _stat('Agents', '${branch.agents}'),
            const SizedBox(width: 28),
            _stat('Total items', '${branch.totalItems}'),
            const SizedBox(width: 28),
            _stat('Low stock', '${branch.lowStock}',
                valueColor: AppColors.coralRed),
          ],
        );

        final chevron = Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: AppColors.textMuted,
        );

        if (isNarrow) {
          // Stacked layout: icon+info on top, stats (scrollable if needed)
          // + chevron on their own row below — nothing gets crushed.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon,
                  const SizedBox(width: 12),
                  Expanded(child: info),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: stats,
                    ),
                  ),
                  const SizedBox(width: 8),
                  chevron,
                ],
              ),
            ],
          );
        }

        // Wide layout: original single row.
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(child: info),
            stats,
            const SizedBox(width: 16),
            chevron,
          ],
        );
      },
    );
  }

  Widget _stat(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppText.cardSubtitle),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: valueColor ?? AppColors.textPrimary)),
      ],
    );
  }
}