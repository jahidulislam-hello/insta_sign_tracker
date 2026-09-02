import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/confirm_delete_dialog.dart';

class SizeScreen extends StatefulWidget {
  const SizeScreen({super.key});

  @override
  State<SizeScreen> createState() => _SizeScreenState();
}

class _SizeScreenState extends State<SizeScreen> {
  final _data = AppData.instance;
  String _query = '';

  List<String> get _signTypeOrder => _data.signTypes.map((e) => e.id).toList();

  List<SizeItem> get _filtered {
    if (_query.trim().isEmpty) return _data.sizes;
    final q = _query.toLowerCase();
    return _data.sizes.where((s) {
      final typeName = _data.signTypeById(s.signTypeId)?.title.toLowerCase() ?? '';
      return s.size.toLowerCase().contains(q) || typeName.contains(q);
    }).toList();
  }

  Future<void> _openForm({SizeItem? existing}) async {
    String? signTypeId = existing?.signTypeId;
    final sizeController = TextEditingController(text: existing?.size ?? '');
    final priceController =
        TextEditingController(text: existing != null ? existing.price.toStringAsFixed(0) : '');
    final isEdit = existing != null;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return FormDialogShell(
            title: isEdit ? 'Edit Size' : 'Add Size',
            primaryLabel: isEdit ? 'Save' : 'Add',
            fields: [
              LabeledDropdown(
                label: 'Sign Type',
                value: signTypeId,
                hint: 'Select a sign type',
                items: _data.signTypes
                    .map((s) => DropdownMenuItem(value: s.id, child: Text(s.title)))
                    .toList(),
                onChanged: (v) => setStateDialog(() => signTypeId = v),
              ),
              LabeledField(
                label: 'Size',
                controller: sizeController,
                hint: '30*15',
              ),
              LabeledField(
                label: 'Price',
                controller: priceController,
                hint: 'Enter price',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
            onPrimaryPressed: () {
              if (signTypeId == null ||
                  sizeController.text.trim().isEmpty ||
                  priceController.text.trim().isEmpty) {
                return;
              }
              Navigator.of(context).pop({
                'signTypeId': signTypeId,
                'size': sizeController.text.trim(),
                'price': double.tryParse(priceController.text.trim()) ?? 0,
              });
            },
          );
        });
      },
    );

    if (result == null) return;
    setState(() {
      if (isEdit) {
        existing.signTypeId = result['signTypeId'];
        existing.size = result['size'];
        existing.price = result['price'];
      } else {
        _data.sizes.add(SizeItem(
          id: _data.nextId(),
          signTypeId: result['signTypeId'],
          size: result['size'],
          price: result['price'],
        ));
      }
    });
  }

  Future<void> _delete(SizeItem item) async {
    final confirmed = await confirmDelete(context, itemName: item.size);
    if (!confirmed) return;
    setState(() => _data.sizes.remove(item));
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return PanelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListHeader(
            title: 'Size',
            total: _data.sizes.length,
            addLabel: 'Add Size',
            onAdd: () => _openForm(),
            onSearchChanged: (v) => setState(() => _query = v),
          ),
          const TableHeaderRow(columns: [
            TableColumnSpec('S.N.', flex: 1),
            TableColumnSpec('Name', flex: 3),
            TableColumnSpec('Sign Type', flex: 3),
            TableColumnSpec('Price', flex: 2),
            TableColumnSpec('Action', flex: 2),
          ]),
          if (items.isEmpty) const EmptyRow(),
          ...List.generate(items.length, (i) {
            final item = items[i];
            final signType = _data.signTypeById(item.signTypeId);
            final badgeColor = BadgePalette.colorFor(item.signTypeId, _signTypeOrder);
            return TableDataRow(
              flexes: const [1, 3, 3, 2, 2],
              cells: [
                Text('${i + 1}', style: AppTextStyles.cellMuted),
                Text(item.size, style: AppTextStyles.cellText),
                ColorChip(label: signType?.title ?? 'Unknown', color: badgeColor),
                Text('\$${item.price.toStringAsFixed(0)}', style: AppTextStyles.price),
                RowActions(
                  onEdit: () => _openForm(existing: item),
                  onDelete: () => _delete(item),
                ),
              ],
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
