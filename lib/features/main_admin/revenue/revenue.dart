import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


/// -----------------------------------------------------------------------
/// MODEL
/// -----------------------------------------------------------------------
class RevenueItem {
  final String name;
  final String email;
  final String date;
  final String paymentId;
  final double amount;
  final double stripeFee;
  final double netAmount;

  const RevenueItem({
    required this.name,
    required this.email,
    required this.date,
    required this.paymentId,
    required this.amount,
    required this.stripeFee,
    required this.netAmount,
  });
}

String _fmt(double v) {
  final isWhole = v == v.roundToDouble();
  return '\$${isWhole ? v.toInt().toString() : v.toStringAsFixed(2)}';
}

/// -----------------------------------------------------------------------
/// MOCK DATA (matches the screenshot)
/// -----------------------------------------------------------------------
const List<RevenueItem> kRevenueItems = [
  RevenueItem(name: 'Vemo Ley', email: 'vemoley923@elygifts.com', date: '04/05/2026', paymentId: 'pi_3SL3JH8K2LmN9Q', amount: 50, stripeFee: 1.75, netAmount: 48.25),
  RevenueItem(name: 'Osman Goni', email: 'gonidev715@gmail.com', date: '05/05/2026', paymentId: 'pi_3SL4PK9D7XtR2M', amount: 50, stripeFee: 1.75, netAmount: 48.25),
  RevenueItem(name: 'Golap Hasan', email: 'golaphasan379@gmail.com', date: '06/05/2026', paymentId: 'pi_3SKG76LQ5YpT8N', amount: 100, stripeFee: 3.2, netAmount: 96.8),
  RevenueItem(name: 'Sarah Johnson', email: 'sarahj@email.com', date: '07/05/2026', paymentId: 'pi_3SKF11AX9QrP4B', amount: 75, stripeFee: 2.4, netAmount: 72.6),
  RevenueItem(name: 'Michael Brown', email: 'michaelbrown@email.com', date: '08/05/2026', paymentId: 'pi_3SKD98LM4VxZ7C', amount: 120, stripeFee: 3.85, netAmount: 116.15),
  RevenueItem(name: 'Emma Wilson', email: 'emmawilson@email.com', date: '10/05/2026', paymentId: 'pi_3SKA55TR8LpW1D', amount: 40, stripeFee: 1.35, netAmount: 38.65),
];

/// -----------------------------------------------------------------------
/// SCREEN
/// -----------------------------------------------------------------------
class RevenueScreen extends StatefulWidget {
  const RevenueScreen({super.key});

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;

  // These mirror the screenshot's summary values, which come from the
  // backend independently of the visible row list — swap in real API
  // values here when wiring this up.
  final double _totalRevenue = 420.70;
  final double _totalFees = 0.00;
  final double _netAmount = 0.00;

  List<RevenueItem> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return kRevenueItems;
    return kRevenueItems
        .where((i) => i.name.toLowerCase().contains(q) || i.email.toLowerCase().contains(q))
        .toList();
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final initial = (isFrom ? _fromDate : _toDate) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (isFrom) {
        _fromDate = picked;
      } else {
        _toDate = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppColors.radiusLg),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 6),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 40),
                      child: _buildTable(items),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // HEADER: title, From/To filters, summary cards, search
  // ---------------------------------------------------------------------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Row 1: Title + Search ──
          Row(
            children: [
              const Text(
                'Revenue',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const Spacer(),
              Flexible(child: _searchField()),
            ],
          ),
          const SizedBox(height: 14),
          // ── Row 2: Date range filter ──
          _dateRangeFilter(),
          const SizedBox(height: 16),
          // ── Row 3: Summary cards ──
          Row(
            children: [
              Expanded(
                child: _summaryCard(
                  label: 'Total Revenue',
                  value: _fmt(_totalRevenue),
                  bg: AppColors.greenLight,
                  border: const Color(0xFFBFE8CE),
                  textColor: AppColors.green,
                  footer: 'View details',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _summaryCard(
                  label: 'Total Fees',
                  value: _fmt(_totalFees),
                  bg: const Color(0xFFFFF9E1),
                  border: const Color(0xFFF3E6A8),
                  textColor: AppColors.amberLabel,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _summaryCard(
                  label: 'Net Amount',
                  value: _fmt(_netAmount),
                  bg: AppColors.lightBlueBg,
                  border: const Color(0xFFBFDCF7),
                  textColor: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateRangeFilter() {
    return Row(
      children: [
        _dateChip(label: 'From', value: _fromDate, onTap: () => _pickDate(isFrom: true)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('-', style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
        ),
        _dateChip(label: 'To', value: _toDate, onTap: () => _pickDate(isFrom: false)),
      ],
    );
  }

  Widget _dateChip({required String label, required DateTime? value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textPrimary),
            const SizedBox(width: 6),
            Text(
              value == null ? label : '${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}/${value.year}',
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required String label,
    required String value,
    required Color bg,
    required Color border,
    required Color textColor,
    String? footer,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(fontSize: 11.5, color: textColor.withOpacity(0.85))),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: textColor)),
          if (footer != null) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    footer,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: textColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 2),
                Icon(Icons.arrow_forward, size: 11, color: textColor),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _searchField() {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 17, color: AppColors.textMuted),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: _searchCtrl,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(fontSize: 12.5, color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Search by name or email...',
                hintStyle: TextStyle(fontSize: 12.5, color: AppColors.textMuted),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TABLE
  // ---------------------------------------------------------------------
  static const Map<String, int> _colFlex = {
    'sn': 3,
    'name': 12,
    'email': 16,
    'date': 9,
    'paymentId': 16,
    'amount': 8,
    'stripeFee': 9,
    'netAmount': 9,
    'action': 6,
  };

  Widget _buildTable(List<RevenueItem> items) {
    return SizedBox(
      width: 1500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _tableHeaderRow(),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text('No matching payments found.', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
              ),
            )
          else
            ...List.generate(items.length, (i) => _tableDataRow(i + 1, items[i])),
        ],
      ),
    );
  }

  Widget _tableHeaderRow() {
    return Container(
      color: AppColors.blueLight,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          _headerCell('S.N.', _colFlex['sn']!),
          _headerCell('Cardholders Name', _colFlex['name']!),
          _headerCell('Email', _colFlex['email']!),
          _headerCell('Date', _colFlex['date']!),
          _headerCell('Payment ID', _colFlex['paymentId']!),
          _headerCell('Amount', _colFlex['amount']!),
          _headerCell('Stripe Fee', _colFlex['stripeFee']!),
          _headerCell('Net Amount', _colFlex['netAmount']!),
          _headerCell('Action', _colFlex['action']!),
        ],
      ),
    );
  }

  Widget _headerCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
    );
  }

  Widget _tableDataRow(int sn, RevenueItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.rowBorder)),
      ),
      child: Row(
        children: [
          _dataCell('$sn', _colFlex['sn']!),
          _dataCell(item.name, _colFlex['name']!, style: AppText.cellLink),
          _dataCell(item.email, _colFlex['email']!, style: AppText.cellLink),
          _dataCell(item.date, _colFlex['date']!),
          _dataCell(item.paymentId, _colFlex['paymentId']!),
          _dataCell(_fmt(item.amount), _colFlex['amount']!, style: AppText.cellLink),
          _dataCell(_fmt(item.stripeFee), _colFlex['stripeFee']!),
          _dataCell(_fmt(item.netAmount), _colFlex['netAmount']!, style: AppText.cellLink),
          Expanded(
            flex: _colFlex['action']!,
            child: GestureDetector(
              onTap: () => _showDetails(item),
              child: const Icon(Icons.remove_red_eye_outlined, size: 18, color: AppColors.iconView),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataCell(String text, int flex, {TextStyle? style}) {
    return Expanded(
      flex: flex,
      child: Text(text, overflow: TextOverflow.ellipsis, style: style ?? AppText.cell),
    );
  }

  void _showDetails(RevenueItem item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppColors.radiusMd)),
        title: Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow('Email', item.email),
            _detailRow('Date', item.date),
            _detailRow('Payment ID', item.paymentId),
            _detailRow('Amount', _fmt(item.amount)),
            _detailRow('Stripe Fee', _fmt(item.stripeFee)),
            _detailRow('Net Amount', _fmt(item.netAmount)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
          const SizedBox(width: 16),
          Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}