import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/list_page_header.dart';
import '../widgets/row_actions.dart';
import '../widgets/app_dialog_shell.dart';

enum CouponStatus { active, expired, inactive }

class CouponRow {
  String code;
  double discountValue;
  bool isPercentage;
  DateTime? expires;
  int used;
  int limit;
  CouponStatus status;

  CouponRow({
    required this.code,
    required this.discountValue,
    required this.isPercentage,
    this.expires,
    required this.used,
    required this.limit,
    required this.status,
  });

  String get discountLabel => isPercentage ? '${discountValue.toStringAsFixed(0)}%' : '\$${discountValue.toStringAsFixed(0)}';
}

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final List<CouponRow> _coupons = [
    CouponRow(code: 'SAVE20', discountValue: 20, isPercentage: true, expires: DateTime(2024, 12, 31), used: 45, limit: 100, status: CouponStatus.active),
    CouponRow(code: 'FLAT50', discountValue: 50, isPercentage: false, expires: DateTime(2024, 11, 30), used: 32, limit: 50, status: CouponStatus.active),
    CouponRow(code: 'SUMMER30', discountValue: 30, isPercentage: true, expires: DateTime(2024, 6, 30), used: 198, limit: 200, status: CouponStatus.expired),
    CouponRow(code: 'WELCOME10', discountValue: 10, isPercentage: true, expires: DateTime(2025, 12, 31), used: 542, limit: 1000, status: CouponStatus.active),
    CouponRow(code: 'VIPCLUB', discountValue: 25, isPercentage: true, expires: DateTime(2025, 6, 30), used: 18, limit: 75, status: CouponStatus.active),
    CouponRow(code: 'FREESHIP', discountValue: 100, isPercentage: false, expires: DateTime(2024, 10, 15), used: 287, limit: 300, status: CouponStatus.inactive),
  ];

  String _query = '';

  List<CouponRow> get _filtered =>
      _coupons.where((c) => c.code.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openDialog({CouponRow? existing}) async {
    final result = await showDialog<CouponRow>(
      context: context,
      builder: (_) => _CreateCouponDialog(existing: existing),
    );
    if (result == null) return;
    setState(() {
      if (existing != null) {
        _coupons[_coupons.indexOf(existing)] = result;
      } else {
        _coupons.add(result);
      }
    });
  }

  void _delete(CouponRow c) => setState(() => _coupons.remove(c));

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
                  title: 'Coupons',
                  total: _coupons.length,
                  addLabel: 'Add Coupon',
                  onAdd: () => _openDialog(),
                  onSearch: (v) => setState(() => _query = v),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(width: 980, child: _table(rows)),
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

  static const _wCode = 130.0;
  static const _wDiscount = 100.0;
  static const _wExpires = 120.0;
  static const _wUsage = 180.0;
  static const _wStatus = 100.0;
  static const _wActions = 90.0;

  Widget _table(List<CouponRow> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            SizedBox(width: _wCode, child: Text('Code', style: AppText.columnHeader)),
            SizedBox(width: _wDiscount, child: Text('Discount', style: AppText.columnHeader)),
            SizedBox(width: _wExpires, child: Text('Expires', style: AppText.columnHeader)),
            SizedBox(width: _wUsage, child: Text('Usage', style: AppText.columnHeader)),
            SizedBox(width: _wStatus, child: Text('Status', style: AppText.columnHeader)),
            SizedBox(width: _wActions, child: Text('Actions', style: AppText.columnHeader)),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: AppColors.border),
        for (int i = 0; i < rows.length; i++) ...[
          Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: _row(rows[i])),
          const Divider(height: 1, color: AppColors.border),
        ],
      ],
    );
  }

  Widget _row(CouponRow c) {
    final usageRatio = c.limit == 0 ? 0.0 : (c.used / c.limit).clamp(0.0, 1.0);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: _wCode, child: Text(c.code, style: AppText.cell)),
        SizedBox(width: _wDiscount, child: Text(c.discountLabel, style: AppText.cellLink)),
        SizedBox(width: _wExpires, child: Text(_fmtDate(c.expires), style: AppText.cell)),
        SizedBox(
          width: _wUsage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${c.used}/${c.limit}', style: AppText.cell),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: usageRatio,
                  minHeight: 5,
                  backgroundColor: const Color(0xFFE5E7EB),
                  valueColor: const AlwaysStoppedAnimation(AppColors.blue),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: _wStatus, child: _statusPill(c.status)),
        SizedBox(
          width: _wActions,
          child: RowActions(onEdit: () => _openDialog(existing: c), onDelete: () => _delete(c)),
        ),
      ],
    );
  }

  Widget _statusPill(CouponStatus s) {
    switch (s) {
      case CouponStatus.active:
        return const Pill(label: 'active', bg: AppColors.blue, fg: Colors.white);
      case CouponStatus.expired:
        return const Pill(label: 'expired', bg: AppColors.red, fg: Colors.white);
      case CouponStatus.inactive:
        return const Pill(label: 'inactive', bg: AppColors.greenLight, fg: AppColors.green);
    }
  }
}

class _CreateCouponDialog extends StatefulWidget {
  final CouponRow? existing;
  const _CreateCouponDialog({this.existing});

  @override
  State<_CreateCouponDialog> createState() => _CreateCouponDialogState();
}

class _CreateCouponDialogState extends State<_CreateCouponDialog> {
  late final TextEditingController _code;
  late final TextEditingController _value;
  late final TextEditingController _limit;
  String? _discountType;
  DateTime? _expiry;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _code = TextEditingController(text: e?.code ?? '');
    _value = TextEditingController(text: e?.discountValue.toString() ?? '');
    _limit = TextEditingController(text: e?.limit.toString() ?? '');
    _discountType = e == null ? 'Percentage (%)' : (e.isPercentage ? 'Percentage (%)' : 'Fixed Amount (\$)');
    _expiry = e?.expires;
  }

  @override
  void dispose() {
    _code.dispose();
    _value.dispose();
    _limit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit Coupon' : 'Create New Coupon',
      primaryLabel: _isEdit ? 'Save Coupon' : 'Create Coupon',
      secondaryLabel: 'Cancel',
      onPrimaryPressed: () {
        Navigator.of(context).pop(CouponRow(
          code: _code.text.isEmpty ? (widget.existing?.code ?? 'CODE') : _code.text.toUpperCase(),
          discountValue: double.tryParse(_value.text) ?? 0,
          isPercentage: _discountType == 'Percentage (%)',
          expires: _expiry,
          used: widget.existing?.used ?? 0,
          limit: int.tryParse(_limit.text) ?? (widget.existing?.limit ?? 0),
          status: widget.existing?.status ?? CouponStatus.active,
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledField(label: 'Coupon Code', controller: _code, hint: 'e.g., SAVE20'),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Discount Value', controller: _value, hint: 'Enter amount', keyboardType: TextInputType.number),
          const SizedBox(height: 14),
          AppLabeledDropdown(
            label: 'Discount Type',
            value: _discountType,
            items: const ['Percentage (%)', 'Fixed Amount (\$)'],
            onChanged: (v) => setState(() => _discountType = v),
          ),
          const SizedBox(height: 14),
          AppLabeledDateField(label: 'Expiry Date', value: _expiry, onChanged: (d) => setState(() => _expiry = d)),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Usage Limit', controller: _limit, hint: 'e.g., 100', keyboardType: TextInputType.number),
        ],
      ),
    );
  }
}
