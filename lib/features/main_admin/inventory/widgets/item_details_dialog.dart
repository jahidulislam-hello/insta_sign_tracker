import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models.dart';
import 'common.dart';

/// "Inventory Item Details" popup — shown when the eye (view) icon is
/// pressed on a Table View row. Matches screenshot 3.
class ItemDetailsDialog extends StatefulWidget {
  final InventoryItem item;
  const ItemDetailsDialog({super.key, required this.item});

  static Future<void> show(BuildContext context, InventoryItem item) {
    return showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => ItemDetailsDialog(item: item),
    );
  }

  @override
  State<ItemDetailsDialog> createState() => _ItemDetailsDialogState();
}

class _ItemDetailsDialogState extends State<ItemDetailsDialog> {
  bool specsExpanded = true;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        width: 660,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
        decoration: modalDecoration(radius: 14),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inventory Item Details',
                            style: AppText.dialogTitle),
                        const SizedBox(height: 2),
                        Text('ID:${item.id}', style: AppText.bodyMuted),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.redLight,
                      child: Icon(Icons.close,
                          size: 14, color: AppColors.coralRed),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24, color: AppColors.border),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column
                  SizedBox(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: AppColors.fieldFill,
                            borderRadius:
                                BorderRadius.circular(AppColors.radiusMd),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(Icons.image_outlined,
                              size: 40, color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 12),
                        _infoBox(
                          label: 'Quantity Available',
                          value: '${item.qty}',
                          bg: AppColors.blueLight,
                          valueColor: AppColors.primaryBlue,
                        ),
                        const SizedBox(height: 10),
                        _infoBox(
                          label: 'Status',
                          value: item.status,
                          bg: AppColors.greenLight,
                          valueColor: AppColors.green,
                        ),
                        const SizedBox(height: 10),
                        SecondaryButton(
                          label: 'Download ${item.qty} Code',
                          icon: Icons.download,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Right column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(item.name,
                                  style: AppText.headingDark),
                            ),
                            const StatusChip(
                              label: 'Agent Inventory',
                              colors:
                                  BadgeColor(AppColors.blueBadgeBg, AppColors.blue),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        _infoGrid([
                          _InfoField(Icons.sell_outlined, 'ITEM TYPE', item.type),
                          _InfoField(Icons.person_outline, 'ASSIGNED AGENT',
                              item.assignedAgent),
                          _InfoField(Icons.location_on_outlined,
                              'WAREHOUSE LOCATION', item.warehouseLocation),
                          _InfoField(Icons.calendar_today_outlined,
                              'LAST UPDATED', item.lastUpdated),
                          _InfoField(Icons.attach_money, 'UNIT PRICE',
                              item.unitPrice),
                          _InfoField(Icons.tag, 'SERIAL NO', item.serialNo),
                          _InfoField(Icons.local_shipping_outlined,
                              'SHIPMENT', item.shipment),
                          _InfoField(Icons.reorder, 'SHELVE NO',
                              item.shelveNo),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Sign Specifications
              Row(
                children: [
                  const Icon(Icons.sell_outlined,
                      size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text('Sign Specifications',
                          style: AppText.fieldLabel)),
                  Switch(
                    value: specsExpanded,
                    activeColor: AppColors.primaryBlue,
                    onChanged: (v) => setState(() => specsExpanded = v),
                  ),
                ],
              ),
              if (specsExpanded)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(AppColors.radiusMd),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: _specField('Size', item.size)),
                          Expanded(
                              child: _specField('Material', item.material)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                              child:
                                  _specField('Mount type', item.mountType)),
                          Expanded(
                              child: _specField('Additional specifications',
                                  item.additionalSpecs)),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Text('Notes', style: AppText.fieldLabel),
              const SizedBox(height: 6),
              TextField(
                controller: TextEditingController(text: item.notes),
                decoration: inputDecoration(hint: 'Type Here..'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(
                      label: 'Close',
                      onPressed: () => Navigator.of(context).pop()),
                  const SizedBox(width: 8),
                  PrimaryButton(label: 'Edit Item', onPressed: () {}),
                  const SizedBox(width: 8),
                  SecondaryButton(label: 'Check Out', onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoBox({
    required String label,
    required String value,
    required Color bg,
    required Color valueColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.bodyMuted),
          const SizedBox(height: 2),
          Text(value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700, color: valueColor)),
        ],
      ),
    );
  }

  Widget _infoGrid(List<_InfoField> fields) {
    return Wrap(
      spacing: 24,
      runSpacing: 14,
      children: fields.map((f) {
        return SizedBox(
          width: 210,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(f.icon, size: 15, color: AppColors.textMuted),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(f.label,
                        style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textMuted,
                            letterSpacing: 0.3)),
                    const SizedBox(height: 2),
                    Text(f.value, style: AppText.cell),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _specField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.bodyMuted),
        const SizedBox(height: 4),
        Text(value, style: AppText.cell),
      ],
    );
  }
}

class _InfoField {
  final IconData icon;
  final String label;
  final String value;
  _InfoField(this.icon, this.label, this.value);
}
