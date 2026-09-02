import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/list_page_header.dart';
import '../widgets/row_actions.dart';
import '../widgets/app_dialog_shell.dart';

class PurchaseOrder {
  String name;
  String category;
  String vendor;
  DateTime? purchaseDate;
  DateTime? receivedDate;
  double unitCost;
  double invoiceAmount;

  PurchaseOrder({
    required this.name,
    required this.category,
    required this.vendor,
    this.purchaseDate,
    this.receivedDate,
    required this.unitCost,
    required this.invoiceAmount,
  });
}

class PurchaseOrdersScreen extends StatefulWidget {
  const PurchaseOrdersScreen({super.key});

  @override
  State<PurchaseOrdersScreen> createState() => _PurchaseOrdersScreenState();
}

class _PurchaseOrdersScreenState extends State<PurchaseOrdersScreen> {
  static const categories = ['Sign Post', 'Main Panel', 'Rider Panel'];

  final List<PurchaseOrder> _orders = [
    PurchaseOrder(name: 'Aluminum Sheet', category: 'Sign Post', vendor: 'ABC Metals', purchaseDate: DateTime(2026, 4, 1), receivedDate: DateTime(2026, 4, 3), unitCost: 12, invoiceAmount: 120),
    PurchaseOrder(name: 'Acrylic Board', category: 'Main Panel', vendor: 'Plastico Ltd', purchaseDate: DateTime(2026, 4, 2), receivedDate: DateTime(2026, 4, 4), unitCost: 9.5, invoiceAmount: 95),
    PurchaseOrder(name: 'PVC Foam Board', category: 'Rider Panel', vendor: 'Foam House', purchaseDate: DateTime(2026, 4, 3), receivedDate: DateTime(2026, 4, 5), unitCost: 7.5, invoiceAmount: 75),
    PurchaseOrder(name: 'LED Strip', category: 'Sign Post', vendor: 'Bright Lights Co', purchaseDate: DateTime(2026, 4, 4), receivedDate: DateTime(2026, 4, 6), unitCost: 4.5, invoiceAmount: 45),
    PurchaseOrder(name: 'Steel Frame', category: 'Main Panel', vendor: 'SteelWorks Ltd', purchaseDate: DateTime(2026, 4, 5), receivedDate: DateTime(2026, 4, 7), unitCost: 15, invoiceAmount: 150),
    PurchaseOrder(name: 'Glass Panel', category: 'Rider Panel', vendor: 'ClearView Glass', purchaseDate: DateTime(2026, 4, 6), receivedDate: DateTime(2026, 4, 8), unitCost: 18, invoiceAmount: 180),
    PurchaseOrder(name: 'Vinyl Sticker Roll', category: 'Sign Post', vendor: 'PrintPro Supplies', purchaseDate: DateTime(2026, 4, 7), receivedDate: DateTime(2026, 4, 9), unitCost: 6, invoiceAmount: 60),
    PurchaseOrder(name: 'Wooden Panel', category: 'Main Panel', vendor: 'Timber Mart', purchaseDate: DateTime(2026, 4, 8), receivedDate: DateTime(2026, 4, 10), unitCost: 11, invoiceAmount: 110),
    PurchaseOrder(name: 'Backlit Flex', category: 'Rider Panel', vendor: 'FlexPrint Ltd', purchaseDate: DateTime(2026, 4, 9), receivedDate: DateTime(2026, 4, 11), unitCost: 8.5, invoiceAmount: 85),
    PurchaseOrder(name: 'LED Driver', category: 'Sign Post', vendor: 'PowerTech', purchaseDate: DateTime(2026, 4, 10), receivedDate: DateTime(2026, 4, 12), unitCost: 5.5, invoiceAmount: 55),
  ];

  String _query = '';

  List<PurchaseOrder> get _filtered =>
      _orders.where((o) => o.name.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openDialog({PurchaseOrder? existing}) async {
    final result = await showDialog<PurchaseOrder>(
      context: context,
      builder: (_) => _AddVariantDialog(existing: existing),
    );
    if (result == null) return;
    setState(() {
      if (existing != null) {
        _orders[_orders.indexOf(existing)] = result;
      } else {
        _orders.add(result);
      }
    });
  }

  void _delete(PurchaseOrder o) => setState(() => _orders.remove(o));

  String _fmtDate(DateTime? d) => d == null
      ? '—'
      : '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

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
                  title: 'Purchase Orders',
                  total: _orders.length,
                  addLabel: 'Add Variant',
                  onAdd: () => _openDialog(),
                  onSearch: (v) => setState(() => _query = v),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(width: 1080, child: _table(rows)),
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

  static const _wSn = 50.0;
  static const _wName = 170.0;
  static const _wCategory = 110.0;
  static const _wVendor = 140.0;
  static const _wPurchase = 120.0;
  static const _wReceived = 120.0;
  static const _wUnit = 80.0;
  static const _wInvoice = 100.0;
  static const _wActions = 90.0;

  Widget _table(List<PurchaseOrder> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            SizedBox(width: _wSn, child: Text('S.N.', style: AppText.columnHeader)),
            SizedBox(width: _wName, child: Text('Name', style: AppText.columnHeader)),
            SizedBox(width: _wCategory, child: Text('Category', style: AppText.columnHeader)),
            SizedBox(width: _wVendor, child: Text('Vendor', style: AppText.columnHeader)),
            SizedBox(width: _wPurchase, child: Text('Purchase Date', style: AppText.columnHeader)),
            SizedBox(width: _wReceived, child: Text('Received Date', style: AppText.columnHeader)),
            SizedBox(width: _wUnit, child: Text('Unit Cost', style: AppText.columnHeader)),
            SizedBox(width: _wInvoice, child: Text('Invoice Amount', style: AppText.columnHeader)),
            SizedBox(width: _wActions, child: Text('Action', style: AppText.columnHeader)),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: AppColors.border),
        for (int i = 0; i < rows.length; i++) ...[
          Padding(padding: const EdgeInsets.symmetric(vertical: 11), child: _row(i + 1, rows[i])),
          const Divider(height: 1, color: AppColors.border),
        ],
      ],
    );
  }

  Widget _row(int sn, PurchaseOrder o) {
    final colors = BadgeColors.forKey(o.category, categories);
    return Row(
      children: [
        SizedBox(width: _wSn, child: Text('$sn', style: AppText.cellMuted)),
        SizedBox(width: _wName, child: Text(o.name, style: AppText.cell)),
        SizedBox(width: _wCategory, child: Pill(label: o.category, bg: colors[0], fg: colors[1], dense: true)),
        SizedBox(width: _wVendor, child: Text(o.vendor, style: AppText.cell, overflow: TextOverflow.ellipsis)),
        SizedBox(width: _wPurchase, child: Text(_fmtDate(o.purchaseDate), style: AppText.cell)),
        SizedBox(width: _wReceived, child: Text(_fmtDate(o.receivedDate), style: AppText.cell)),
        SizedBox(width: _wUnit, child: Text('\$${o.unitCost}', style: AppText.cellLink)),
        SizedBox(width: _wInvoice, child: Text('\$${o.invoiceAmount.toStringAsFixed(0)}', style: AppText.cellLink)),
        SizedBox(
          width: _wActions,
          child: RowActions(onEdit: () => _openDialog(existing: o), onDelete: () => _delete(o)),
        ),
      ],
    );
  }
}

class _AddVariantDialog extends StatefulWidget {
  final PurchaseOrder? existing;
  const _AddVariantDialog({this.existing});

  @override
  State<_AddVariantDialog> createState() => _AddVariantDialogState();
}

class _AddVariantDialogState extends State<_AddVariantDialog> {
  late final TextEditingController _name;
  late final TextEditingController _vendor;
  late final TextEditingController _invoice;
  late final TextEditingController _unitCost;
  String? _category;
  DateTime? _purchaseDate;
  DateTime? _receivedDate;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name ?? '');
    _vendor = TextEditingController(text: e?.vendor ?? '');
    _invoice = TextEditingController(text: e?.invoiceAmount.toString() ?? '');
    _unitCost = TextEditingController(text: e?.unitCost.toString() ?? '');
    _category = e?.category;
    _purchaseDate = e?.purchaseDate;
    _receivedDate = e?.receivedDate;
  }

  @override
  void dispose() {
    _name.dispose();
    _vendor.dispose();
    _invoice.dispose();
    _unitCost.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit Variant' : 'Add Variant',
      primaryLabel: _isEdit ? 'Save' : 'Add',
      onPrimaryPressed: () {
        Navigator.of(context).pop(PurchaseOrder(
          name: _name.text.isEmpty ? (widget.existing?.name ?? 'Untitled') : _name.text,
          category: _category ?? (widget.existing?.category ?? ''),
          vendor: _vendor.text,
          purchaseDate: _purchaseDate,
          receivedDate: _receivedDate,
          unitCost: double.tryParse(_unitCost.text) ?? 0,
          invoiceAmount: double.tryParse(_invoice.text) ?? 0,
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledField(label: 'Name', controller: _name, hint: 'Type here..'),
          const SizedBox(height: 14),
          AppLabeledDropdown(
            label: 'Category',
            value: _category,
            hint: 'Select a category',
            items: _PurchaseOrdersScreenState.categories,
            onChanged: (v) => setState(() => _category = v),
          ),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Vendor Name', controller: _vendor, hint: 'Type here..'),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Invoice Amount', controller: _invoice, hint: 'Enter price', keyboardType: TextInputType.number),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Unit Cost', controller: _unitCost, hint: 'Enter cost', keyboardType: TextInputType.number),
          const SizedBox(height: 14),
          AppLabeledDateField(label: 'Purchase Date', value: _purchaseDate, onChanged: (d) => setState(() => _purchaseDate = d)),
          const SizedBox(height: 14),
          AppLabeledDateField(label: 'Received Date', value: _receivedDate, onChanged: (d) => setState(() => _receivedDate = d)),
        ],
      ),
    );
  }
}
