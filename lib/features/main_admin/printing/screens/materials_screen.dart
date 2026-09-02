import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'package:intl/intl.dart';
import '../models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/confirm_delete_dialog.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  final _data = AppData.instance;
  String _query = '';
  String? _categoryFilter;
  final _dateFmt = DateFormat('yyyy-MM-dd');

  List<MaterialItem> get _filtered {
    return _data.materials.where((m) {
      final matchesCategory = _categoryFilter == null || m.category == _categoryFilter;
      final q = _query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          m.name.toLowerCase().contains(q) ||
          m.vendor.toLowerCase().contains(q) ||
          m.category.toLowerCase().contains(q);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Future<void> _openForm({MaterialItem? existing}) async {
    final nameController = TextEditingController(text: existing?.name ?? '');
    final vendorController = TextEditingController(text: existing?.vendor ?? '');
    final priceController =
        TextEditingController(text: existing != null ? existing.price.toStringAsFixed(0) : '');
    final unitCostController =
        TextEditingController(text: existing != null ? existing.unitCost.toString() : '');
    String? category = existing?.category;
    DateTime? purchaseDate = existing?.purchaseDate;
    DateTime? receivedDate = existing?.receivedDate;
    final isEdit = existing != null;

    final purchaseController = TextEditingController(
        text: purchaseDate != null ? _dateFmt.format(purchaseDate) : '');
    final receivedController = TextEditingController(
        text: receivedDate != null ? _dateFmt.format(receivedDate) : '');

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          Future<void> pickDate(bool isPurchase) async {
            final picked = await showDatePicker(
              context: context,
              initialDate: (isPurchase ? purchaseDate : receivedDate) ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );
            if (picked == null) return;
            setStateDialog(() {
              if (isPurchase) {
                purchaseDate = picked;
                purchaseController.text = _dateFmt.format(picked);
              } else {
                receivedDate = picked;
                receivedController.text = _dateFmt.format(picked);
              }
            });
          }

          return FormDialogShell(
            title: isEdit ? 'Edit Material' : 'Add Material',
            primaryLabel: isEdit ? 'Save' : 'Add',
            fields: [
              LabeledField(label: 'Name', controller: nameController, hint: 'Type here..'),
              LabeledDropdown(
                label: 'Category',
                value: category,
                hint: 'Select a category',
                items: _data.materialCategories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setStateDialog(() => category = v),
              ),
              LabeledField(
                  label: 'Vendor Name', controller: vendorController, hint: 'Type here..'),
              LabeledField(
                label: 'Price',
                controller: priceController,
                hint: 'Enter price',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              LabeledField(
                label: 'Unit Cost',
                controller: unitCostController,
                hint: 'Enter cost',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              LabeledField(
                label: 'Purchase Date',
                controller: purchaseController,
                hint: 'mm/dd/yyyy',
                readOnly: true,
                onTap: () => pickDate(true),
                suffixIcon: const Icon(Icons.calendar_today_outlined,
                    size: 18, color: AppColors.textMuted),
              ),
              LabeledField(
                label: 'Received Date',
                controller: receivedController,
                hint: 'mm/dd/yyyy',
                readOnly: true,
                onTap: () => pickDate(false),
                suffixIcon: const Icon(Icons.calendar_today_outlined,
                    size: 18, color: AppColors.textMuted),
              ),
            ],
            onPrimaryPressed: () {
              if (nameController.text.trim().isEmpty ||
                  category == null ||
                  vendorController.text.trim().isEmpty) {
                return;
              }
              Navigator.of(context).pop({
                'name': nameController.text.trim(),
                'category': category,
                'vendor': vendorController.text.trim(),
                'price': double.tryParse(priceController.text.trim()) ?? 0,
                'unitCost': double.tryParse(unitCostController.text.trim()) ?? 0,
                'purchaseDate': purchaseDate,
                'receivedDate': receivedDate,
              });
            },
          );
        });
      },
    );

    if (result == null) return;
    setState(() {
      if (isEdit) {
        existing.name = result['name'];
        existing.category = result['category'];
        existing.vendor = result['vendor'];
        existing.price = result['price'];
        existing.unitCost = result['unitCost'];
        existing.purchaseDate = result['purchaseDate'];
        existing.receivedDate = result['receivedDate'];
      } else {
        _data.materials.add(MaterialItem(
          id: _data.nextId(),
          name: result['name'],
          category: result['category'],
          vendor: result['vendor'],
          price: result['price'],
          unitCost: result['unitCost'],
          purchaseDate: result['purchaseDate'],
          receivedDate: result['receivedDate'],
        ));
      }
    });
  }

  Future<void> _delete(MaterialItem item) async {
    final confirmed = await confirmDelete(context, itemName: item.name);
    if (!confirmed) return;
    setState(() => _data.materials.remove(item));
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return PanelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListHeader(
            title: 'Materials',
            total: _data.materials.length,
            addLabel: 'Add Material',
            onAdd: () => _openForm(),
            onSearchChanged: (v) => setState(() => _query = v),
            filterWidget: _CategoryFilterDropdown(
              value: _categoryFilter,
              categories: _data.materialCategories,
              onChanged: (v) => setState(() => _categoryFilter = v),
            ),
          ),
          const TableHeaderRow(columns: [
            TableColumnSpec('S.N.', flex: 1),
            TableColumnSpec('Name', flex: 3),
            TableColumnSpec('Category', flex: 2),
            TableColumnSpec('Vendor', flex: 2),
            TableColumnSpec('Purchase Date', flex: 2),
            TableColumnSpec('Received Date', flex: 2),
            TableColumnSpec('Unit Cost', flex: 1),
            TableColumnSpec('Price', flex: 1),
            TableColumnSpec('Action', flex: 2),
          ]),
          if (items.isEmpty) const EmptyRow(),
          ...List.generate(items.length, (i) {
            final item = items[i];
            final badgeColor =
                BadgePalette.colorFor(item.category, _data.materialCategories);
            return TableDataRow(
              flexes: const [1, 3, 2, 2, 2, 2, 1, 1, 2],
              cells: [
                Text('${i + 1}', style: AppTextStyles.cellMuted),
                Text(item.name, style: AppTextStyles.cellText),
                ColorChip(label: item.category, color: badgeColor),
                Text(item.vendor, style: AppTextStyles.cellMuted),
                Text(item.purchaseDate != null ? _dateFmt.format(item.purchaseDate!) : '-',
                    style: AppTextStyles.cellMuted),
                Text(item.receivedDate != null ? _dateFmt.format(item.receivedDate!) : '-',
                    style: AppTextStyles.cellMuted),
                Text('\$${item.unitCost}', style: AppTextStyles.cellMuted),
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

class _CategoryFilterDropdown extends StatelessWidget {
  final String? value;
  final List<String> categories;
  final ValueChanged<String?> onChanged;

  const _CategoryFilterDropdown({
    required this.value,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 170,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.searchFieldBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textSecondary, size: 20),
          hint: const Text('Filter by category',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13.5)),
          items: [
            const DropdownMenuItem<String?>(value: null, child: Text('All categories')),
            ...categories.map((c) => DropdownMenuItem<String?>(value: c, child: Text(c))),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
