import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/list_page_header.dart';
import '../widgets/row_actions.dart';
import '../widgets/app_dialog_shell.dart';

class InstallerChargeRow {
  String jobType;
  double amount;
  InstallerChargeRow({required this.jobType, required this.amount});
}

class InstallerChargeScreen extends StatefulWidget {
  const InstallerChargeScreen({super.key});

  @override
  State<InstallerChargeScreen> createState() => _InstallerChargeScreenState();
}

class _InstallerChargeScreenState extends State<InstallerChargeScreen> {
  static const jobTypes = ['Install', 'Removals', 'Reinstall'];

  final List<InstallerChargeRow> _charges = [
    InstallerChargeRow(jobType: 'Install', amount: 120),
    InstallerChargeRow(jobType: 'Removals', amount: 95),
  ];

  String _query = '';

  List<InstallerChargeRow> get _filtered =>
      _charges.where((c) => c.jobType.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openDialog({InstallerChargeRow? existing}) async {
    final result = await showDialog<InstallerChargeRow>(
      context: context,
      builder: (_) => _AddChargeDialog(existing: existing),
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

  void _delete(InstallerChargeRow c) => setState(() => _charges.remove(c));

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
                  title: 'Installer Charge',
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
                              Expanded(child: Text('Job Type', style: AppText.columnHeader)),
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

  Widget _row(int sn, InstallerChargeRow c) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 60, child: Padding(padding: const EdgeInsets.only(left: 16), child: Text('$sn', style: AppText.cellMuted))),
          Expanded(child: Text(c.jobType, style: AppText.cell)),
          Expanded(child: Text('\$${c.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 13, color: AppColors.amber))),
          SizedBox(
            width: 100,
            child: RowActions(onEdit: () => _openDialog(existing: c), onDelete: () => _delete(c)),
          ),
        ],
      ),
    );
  }
}

class _AddChargeDialog extends StatefulWidget {
  final InstallerChargeRow? existing;
  const _AddChargeDialog({this.existing});

  @override
  State<_AddChargeDialog> createState() => _AddChargeDialogState();
}

class _AddChargeDialogState extends State<_AddChargeDialog> {
  late final TextEditingController _amount;
  String? _jobType;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _amount = TextEditingController(text: widget.existing?.amount.toString() ?? '');
    _jobType = widget.existing?.jobType;
  }

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit Charge' : 'Add Charge',
      primaryLabel: _isEdit ? 'Save' : 'Add',
      width: 360,
      onPrimaryPressed: () {
        Navigator.of(context).pop(InstallerChargeRow(
          jobType: _jobType ?? (widget.existing?.jobType ?? ''),
          amount: double.tryParse(_amount.text) ?? 0,
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledDropdown(
            label: 'Job Type',
            value: _jobType,
            items: _InstallerChargeScreenState.jobTypes,
            onChanged: (v) => setState(() => _jobType = v),
          ),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Charge Amount', controller: _amount, hint: 'Enter amount', keyboardType: TextInputType.number),
        ],
      ),
    );
  }
}
