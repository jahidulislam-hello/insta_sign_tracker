import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/list_page_header.dart';
import '../widgets/row_actions.dart';
import '../widgets/app_dialog_shell.dart';

class CategoryItem {
  String name;
  String itemType;
  String warehouseLocation;
  String price;
  String barcode;
  String material;
  String color;
  String height;

  CategoryItem({
    required this.name,
    this.itemType = '',
    this.warehouseLocation = '',
    this.price = '',
    this.barcode = '',
    this.material = '',
    this.color = '',
    this.height = '',
  });
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<CategoryItem> _items = [
    CategoryItem(name: 'Sign Post'),
    CategoryItem(name: 'Main Panel'),
    CategoryItem(name: 'Rider Panel'),
  ];

  String _query = '';

  List<CategoryItem> get _filtered =>
      _items.where((c) => c.name.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openDialog({CategoryItem? existing}) async {
    final result = await showDialog<CategoryItem>(
      context: context,
      builder: (_) => _AddItemDialog(
        existing: existing,
        categoryOptions: _items.map((e) => e.name).toList(),
      ),
    );
    if (result == null) return;
    setState(() {
      if (existing != null) {
        final idx = _items.indexOf(existing);
        _items[idx] = result;
      } else {
        _items.add(result);
      }
    });
  }

  void _delete(CategoryItem item) => setState(() => _items.remove(item));

  @override
  Widget build(BuildContext context) {
    final rows = _filtered;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListPageHeader(
                  title: 'Categories',
                  total: _items.length,
                  addLabel: 'New Item',
                  onAdd: () => _openDialog(),
                  onSearch: (v) => setState(() => _query = v),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                          ),
                          child: Row(
                            children: const [
                              SizedBox(width: 60, child: Padding(padding: EdgeInsets.only(left: 16), child: Text('S.N.', style: AppText.columnHeader))),
                              Expanded(child: Text('Name', style: AppText.columnHeader)),
                              SizedBox(width: 100, child: Text('Action', style: AppText.columnHeader)),
                            ],
                          ),
                        ),
                        for (int i = 0; i < rows.length; i++) _row(i + 1, rows[i]),
                        if (rows.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Center(child: Text('No categories found', style: AppText.cellMuted)),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(int sn, CategoryItem item) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 60, child: Padding(padding: const EdgeInsets.only(left: 16), child: Text('$sn', style: AppText.cellMuted))),
          Expanded(child: Text(item.name, style: AppText.cell)),
          SizedBox(
            width: 100,
            child: RowActions(
              onEdit: () => _openDialog(existing: item),
              onDelete: () => _delete(item),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddItemDialog extends StatefulWidget {
  final CategoryItem? existing;
  final List<String> categoryOptions;

  const _AddItemDialog({this.existing, required this.categoryOptions});

  @override
  State<_AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<_AddItemDialog> {
  late final TextEditingController _name;
  late final TextEditingController _warehouse;
  late final TextEditingController _price;
  late final TextEditingController _barcode;
  late final TextEditingController _material;
  late final TextEditingController _color;
  late final TextEditingController _height;
  String? _itemType;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name ?? '');
    _warehouse = TextEditingController(text: e?.warehouseLocation ?? '');
    _price = TextEditingController(text: e?.price ?? '');
    _barcode = TextEditingController(text: e?.barcode ?? '');
    _material = TextEditingController(text: e?.material ?? '');
    _color = TextEditingController(text: e?.color ?? '');
    _height = TextEditingController(text: e?.height ?? '');
    _itemType = (e != null && widget.categoryOptions.contains(e.itemType)) ? e.itemType : null;
  }

  @override
  void dispose() {
    _name.dispose();
    _warehouse.dispose();
    _price.dispose();
    _barcode.dispose();
    _material.dispose();
    _color.dispose();
    _height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit Item' : 'Add Item',
      primaryLabel: _isEdit ? 'Save Item' : 'Save Item',
      onPrimaryPressed: () {
        Navigator.of(context).pop(CategoryItem(
          name: _name.text.isEmpty ? (widget.existing?.name ?? 'Untitled') : _name.text,
          itemType: _itemType ?? '',
          warehouseLocation: _warehouse.text,
          price: _price.text,
          barcode: _barcode.text,
          material: _material.text,
          color: _color.text,
          height: _height.text,
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledField(label: 'Name', controller: _name, hint: 'e.g. Standard Post'),
          const SizedBox(height: 14),
          AppLabeledDropdown(
            label: 'Item Type',
            value: _itemType,
            items: widget.categoryOptions,
            onChanged: (v) => setState(() => _itemType = v),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: AppLabeledField(label: 'Warehouse Location', controller: _warehouse, hint: 'e.g. Aisle 4')),
              const SizedBox(width: 12),
              Expanded(child: AppLabeledField(label: 'Price', controller: _price, hint: '0.00', keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Barcode', controller: _barcode, hint: 'Scan or enter barcode'),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Material', controller: _material, hint: 'e.g. Wood, Metal'),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: AppLabeledField(label: 'Color', controller: _color, hint: 'e.g. White')),
              const SizedBox(width: 12),
              Expanded(child: AppLabeledField(label: 'Height', controller: _height, hint: 'e.g. 6 ft')),
            ],
          ),
        ],
      ),
    );
  }
}
