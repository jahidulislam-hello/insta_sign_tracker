import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models.dart';
import '../widgets/common.dart';

// Fixed widths for each column — keeps the table consistent across rows.
const double _colId = 60;
const double _colQr = 60;
const double _colImg = 60;
const double _colType = 90;
const double _colName = 120;
const double _colQty = 90;
const double _colAgent = 130;
const double _colStatus = 90;
const double _colAction = 90;

class TableViewTab extends StatelessWidget {
  final List<InventoryItem> items;
  final ValueChanged<InventoryItem> onView;

  const TableViewTab({
    super.key,
    required this.items,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: InventorySearchField(hint: 'Search...')),
            const SizedBox(width: 12),
            const FilterButton(label: 'All types'),
            const SizedBox(width: 8),
            const FilterButton(label: 'All Agents', icon: Icons.settings),
            const SizedBox(width: 12),
            Text('Showing ${items.length * 4} items',
                style: AppText.bodyMuted),
          ],
        ),
        const SizedBox(height: 16),
        // Horizontally scrollable table
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TableHeaderRow(),
              const Divider(height: 1, color: AppColors.border),
              ...items.map(
                (item) => _TableRow(item: item, onView: () => onView(item)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TableHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: [
          _cell('Item Id', width: _colId),
          _cell('QR Code', width: _colQr),
          _cell('Image', width: _colImg),
          _cell('Type', width: _colType),
          _cell('Item Name', width: _colName),
          _cell('Qty in stock', width: _colQty),
          _cell('Assigned Agent', width: _colAgent),
          _cell('Status', width: _colStatus),
          _cell('Action', width: _colAction, alignEnd: true),
        ],
      ),
    );
  }

  Widget _cell(String text, {required double width, bool alignEnd = false}) {
    return SizedBox(
      width: width,
      child: Align(
        alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(text, style: AppText.columnHeader),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback onView;
  const _TableRow({required this.item, required this.onView});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Row(
        children: [
          SizedBox(
            width: _colId,
            child: Text(item.id, style: AppText.cell),
          ),
          SizedBox(
            width: _colQr,
            child: const Icon(Icons.qr_code_2,
                size: 40, color: AppColors.textPrimary),
          ),
          SizedBox(
            width: _colImg,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.blueLight,
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.storefront,
                  size: 20, color: AppColors.primaryBlue),
            ),
          ),
          SizedBox(
            width: _colType,
            child: Text(item.type, style: AppText.cell),
          ),
          SizedBox(
            width: _colName,
            child: Text(item.name,
                style: AppText.cell, overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            width: _colQty,
            child: Text('${item.qty}', style: AppText.cell),
          ),
          SizedBox(
            width: _colAgent,
            child: Row(
              children: [
                const AgentAvatar(size: 24),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(item.assignedAgent,
                      style: AppText.cell, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          SizedBox(
            width: _colStatus,
            child: StatusChip(
              label: item.status,
              colors: item.status == 'In Stock'
                  ? StatusBadge.inStock
                  : StatusBadge.outOfStock,
            ),
          ),
          SizedBox(
            width: _colAction,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onView,
                  child: const Icon(Icons.remove_red_eye_outlined,
                      size: 18, color: AppColors.iconView),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.edit_outlined,
                    size: 18, color: AppColors.iconEdit),
                const SizedBox(width: 12),
                const Icon(Icons.settings_outlined,
                    size: 18, color: AppColors.textMuted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
