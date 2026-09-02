import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/list_page_header.dart';
import '../widgets/row_actions.dart';
import '../widgets/app_dialog_shell.dart';

class DiscountRow {
  String customer;
  String postType;
  double price;
  DiscountRow({required this.customer, required this.postType, required this.price});
}

class DiscountsScreen extends StatefulWidget {
  const DiscountsScreen({super.key});

  @override
  State<DiscountsScreen> createState() => _DiscountsScreenState();
}

class _DiscountsScreenState extends State<DiscountsScreen> {
  static const customers = ['John Doe', 'Jane Smith', 'Michael Lee', 'Emily Davis', 'Chris Brown', 'Agent'];
  static const postTypes = ['2 Hole Top', '2 Hole Slider', 'Side Hole', 'Agent'];

  final List<DiscountRow> _discounts = [
    DiscountRow(customer: 'John Doe', postType: '2 Hole Top', price: 120),
    DiscountRow(customer: 'Jane Smith', postType: '2 Hole Slider', price: 95),
    DiscountRow(customer: 'Michael Lee', postType: 'Side Hole', price: 75),
    DiscountRow(customer: 'Emily Davis', postType: '2 Hole Top', price: 130),
    DiscountRow(customer: 'Chris Brown', postType: 'Side Hole', price: 80),
  ];

  String _query = '';

  List<DiscountRow> get _filtered =>
      _discounts.where((d) => d.customer.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openDialog({DiscountRow? existing}) async {
    final result = await showDialog<DiscountRow>(
      context: context,
      builder: (_) => _AddDiscountDialog(existing: existing),
    );
    if (result == null) return;
    setState(() {
      if (existing != null) {
        _discounts[_discounts.indexOf(existing)] = result;
      } else {
        _discounts.add(result);
      }
    });
  }

  void _delete(DiscountRow d) => setState(() => _discounts.remove(d));

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
                  title: 'Discounts',
                  total: _discounts.length,
                  addLabel: 'Add Discount',
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
                          decoration: const BoxDecoration(color: Color(0xFFEFF6FF)),
                          child: Row(
                            children: const [
                              SizedBox(width: 60, child: Padding(padding: EdgeInsets.only(left: 16), child: Text('S.N.', style: AppText.columnHeader))),
                              Expanded(child: Text('Customer', style: AppText.columnHeader)),
                              Expanded(child: Text('Post Type', style: AppText.columnHeader)),
                              Expanded(child: Text('Price', style: AppText.columnHeader)),
                              SizedBox(width: 100, child: Text('Action', style: AppText.columnHeader)),
                            ],
                          ),
                        ),
                        for (int i = 0; i < rows.length; i++) _row(i + 1, rows[i]),
                        if (rows.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Center(child: Text('No discounts found', style: AppText.cellMuted)),
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

  Widget _row(int sn, DiscountRow d) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 60, child: Padding(padding: const EdgeInsets.only(left: 16), child: Text('$sn', style: AppText.cellMuted))),
          Expanded(child: Text(d.customer, style: AppText.cell)),
          Expanded(child: Text(d.postType, style: TextStyle(fontSize: 13, color: AppColors.purple, fontWeight: FontWeight.w600))),
          Expanded(child: Text('\$${d.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
          SizedBox(
            width: 100,
            child: RowActions(onEdit: () => _openDialog(existing: d), onDelete: () => _delete(d)),
          ),
        ],
      ),
    );
  }
}

class _AddDiscountDialog extends StatefulWidget {
  final DiscountRow? existing;
  const _AddDiscountDialog({this.existing});

  @override
  State<_AddDiscountDialog> createState() => _AddDiscountDialogState();
}

class _AddDiscountDialogState extends State<_AddDiscountDialog> {
  late final TextEditingController _price;
  String? _customer;
  String? _postType;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _price = TextEditingController(text: widget.existing?.price.toString() ?? '');
    _customer = widget.existing?.customer;
    _postType = widget.existing?.postType;
  }

  @override
  void dispose() {
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit Discount' : 'Add Discount',
      primaryLabel: _isEdit ? 'Save' : 'Add',
      width: 360,
      onPrimaryPressed: () {
        Navigator.of(context).pop(DiscountRow(
          customer: _customer ?? (widget.existing?.customer ?? ''),
          postType: _postType ?? (widget.existing?.postType ?? ''),
          price: double.tryParse(_price.text) ?? 0,
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledDropdown(
            label: 'Select Customer',
            value: _customer,
            hint: 'Agent',
            items: _DiscountsScreenState.customers,
            onChanged: (v) => setState(() => _customer = v),
          ),
          const SizedBox(height: 14),
          AppLabeledDropdown(
            label: 'Select Post Type',
            value: _postType,
            hint: 'Agent',
            items: _DiscountsScreenState.postTypes,
            onChanged: (v) => setState(() => _postType = v),
          ),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Price', controller: _price, hint: 'Enter price', keyboardType: TextInputType.number),
        ],
      ),
    );
  }
}
