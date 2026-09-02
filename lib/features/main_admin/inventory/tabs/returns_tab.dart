import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models.dart';
import '../widgets/common.dart';

class ReturnsTab extends StatelessWidget {
  final List<ReturnItem> returns;
  final VoidCallback onNewItem;

  const ReturnsTab({
    super.key,
    required this.returns,
    required this.onNewItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: InventorySearchField(hint: 'Search returns...')),
            const SizedBox(width: 8),
            Flexible(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.end,
                children: [
                  const FilterButton(label: 'All types'),
                  const FilterButton(label: 'All Agents', icon: Icons.settings),
                  PrimaryButton(
                      label: 'New Item', icon: Icons.add, onPressed: onNewItem),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppColors.radiusMd),
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.tableHeaderBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppColors.radiusMd),
                    topRight: Radius.circular(AppColors.radiusMd),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    _headerCell('Return Id', flex: 2),
                    _headerCell('Item Name', flex: 4),
                    _headerCell('Qty', flex: 2),
                    _headerCell('Status', flex: 2),
                  ],
                ),
              ),
              if (returns.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Text('No returned items found',
                      style: AppText.cellLink),
                )
              else
                ...returns.map((r) => Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: AppColors.border)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(r.returnId, style: AppText.cell)),
                          Expanded(
                              flex: 4,
                              child:
                                  Text(r.itemName, style: AppText.cell)),
                          Expanded(
                              flex: 2,
                              child: Text('${r.qty}', style: AppText.cell)),
                          Expanded(
                              flex: 2,
                              child: Text(r.status, style: AppText.cell)),
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(text, style: AppText.columnHeader),
    );
  }
}
