import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/list_page_header.dart';
import '../widgets/row_actions.dart';
import '../widgets/app_dialog_shell.dart';

class TripChargeRow {
  String serviceArea;
  double amount;
  TripChargeRow({required this.serviceArea, required this.amount});
}

class TripChargeScreen extends StatefulWidget {
  const TripChargeScreen({super.key});

  @override
  State<TripChargeScreen> createState() => _TripChargeScreenState();
}

class _TripChargeScreenState extends State<TripChargeScreen> {
  final List<TripChargeRow> _charges = [
    TripChargeRow(serviceArea: '0-10 km', amount: 120),
    TripChargeRow(serviceArea: '10-15 km', amount: 95),
  ];

  String _query = '';

  List<TripChargeRow> get _filtered =>
      _charges.where((c) => c.serviceArea.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openDialog({TripChargeRow? existing}) async {
    final result = await showDialog<TripChargeRow>(
      context: context,
      builder: (_) => _SetTripChargeDialog(existing: existing),
    );
    if (result == null) return;
    setState(() {
      if (existing != null) {
        _charges[_charges.indexOf(existing)] = result;
      } else {
        _charges.add(result);
      }
    });
  }

  void _delete(TripChargeRow c) => setState(() => _charges.remove(c));

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
                  title: 'Trip Charge',
                  total: _charges.length,
                  addLabel: 'Add Charge',
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
                              Expanded(child: Text('Service Area', style: AppText.columnHeader)),
                              Expanded(child: Text('Charge Amount', style: AppText.columnHeader)),
                              SizedBox(width: 100, child: Text('Action', style: AppText.columnHeader)),
                            ],
                          ),
                        ),
                        for (int i = 0; i < rows.length; i++) _row(i + 1, rows[i]),
                        if (rows.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Center(child: Text('No charges found', style: AppText.cellMuted)),
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

  Widget _row(int sn, TripChargeRow c) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 60, child: Padding(padding: const EdgeInsets.only(left: 16), child: Text('$sn', style: AppText.cellMuted))),
          Expanded(child: Text(c.serviceArea, style: const TextStyle(fontSize: 13, color: AppColors.blueLink, fontWeight: FontWeight.w600))),
          Expanded(child: Text('\$${c.amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
          SizedBox(
            width: 100,
            child: RowActions(onEdit: () => _openDialog(existing: c), onDelete: () => _delete(c)),
          ),
        ],
      ),
    );
  }
}

class _SetTripChargeDialog extends StatefulWidget {
  final TripChargeRow? existing;
  const _SetTripChargeDialog({this.existing});

  @override
  State<_SetTripChargeDialog> createState() => _SetTripChargeDialogState();
}

class _SetTripChargeDialogState extends State<_SetTripChargeDialog> {
  late final TextEditingController _area;
  late final TextEditingController _amount;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _area = TextEditingController(text: widget.existing?.serviceArea ?? '');
    _amount = TextEditingController(text: widget.existing?.amount.toString() ?? '');
  }

  @override
  void dispose() {
    _area.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit Trip Charges by Area' : 'Set Trip Charges by Area',
      primaryLabel: _isEdit ? 'Save' : 'Add',
      width: 360,
      onPrimaryPressed: () {
        Navigator.of(context).pop(TripChargeRow(
          serviceArea: _area.text.isEmpty ? (widget.existing?.serviceArea ?? '') : _area.text,
          amount: double.tryParse(_amount.text) ?? 0,
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledField(label: 'Service Area', controller: _area, hint: '0-10 km'),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Charge Amount', controller: _amount, hint: 'Enter amount', keyboardType: TextInputType.number),
        ],
      ),
    );
  }
}
