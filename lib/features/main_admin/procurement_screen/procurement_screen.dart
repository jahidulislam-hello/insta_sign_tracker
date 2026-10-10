import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';



/// -----------------------------------------------------------------------
/// MODEL
/// -----------------------------------------------------------------------
class ProcurementItem {
  final String id;
  String name;
  String category;
  String vendor;
  double unitCost;
  double invoiceAmount;
  DateTime purchaseDate;
  DateTime receivedDate;


  ProcurementItem({
    required this.id,
    required this.name,
    required this.category,
    required this.vendor,
    required this.unitCost,
    required this.invoiceAmount,
    required this.purchaseDate,
    required this.receivedDate,
  });

  ProcurementItem copy() => ProcurementItem(
    id: id,
    name: name,
    category: category,
    vendor: vendor,
    unitCost: unitCost,
    invoiceAmount: invoiceAmount,
    purchaseDate: purchaseDate,
    receivedDate: receivedDate,
  );
}

/// -----------------------------------------------------------------------
/// HELPERS
/// -----------------------------------------------------------------------
String _2(int n) => n.toString().padLeft(2, '0');

/// yyyy-MM-dd — used inside the table, matching the screenshot.
String fmtTableDate(DateTime d) => '${d.year}-${_2(d.month)}-${_2(d.day)}';

/// mm/dd/yyyy — used inside the Add/Edit dialog's date fields.
String fmtDialogDate(DateTime d) => '${_2(d.month)}/${_2(d.day)}/${d.year}';

String fmtMoney(double v) {
  final isWhole = v == v.roundToDouble();
  final body = isWhole ? v.toInt().toString() : v.toStringAsFixed(1);
  return '\$$body';
}

const List<String> kCategories = ['Sign Post', 'Main Panel', 'Rider Panel'];

/// (background, text) colors per category badge — matches the pill colors
/// in the screenshot (blue / purple / orange).
({Color bg, Color text}) categoryColors(String category) {
  switch (category) {
    case 'Main Panel':
      return (bg: AppColors.totalBadgeBgAlt, text: AppColors.totalBadgeTextAlt);
    case 'Rider Panel':
      return (bg: AppColors.orangeLight, text: AppColors.orange);
    case 'Sign Post':
    default:
      return (bg: AppColors.lightBlueBg, text: AppColors.primaryBlue);
  }
}

/// -----------------------------------------------------------------------
/// MOCK DATA (matches the screenshot)
/// -----------------------------------------------------------------------
List<ProcurementItem> _seedData() => [
  ProcurementItem(id: '1', name: 'Aluminum Sheet', category: 'Sign Post', vendor: 'ABC Metals', unitCost: 12, invoiceAmount: 120, purchaseDate: DateTime(2026, 4, 1), receivedDate: DateTime(2026, 4, 3)),
  ProcurementItem(id: '2', name: 'Acrylic Board', category: 'Main Panel', vendor: 'Plastico Ltd', unitCost: 9.5, invoiceAmount: 95, purchaseDate: DateTime(2026, 4, 2), receivedDate: DateTime(2026, 4, 4)),
  ProcurementItem(id: '3', name: 'PVC Foam Board', category: 'Rider Panel', vendor: 'Foam House', unitCost: 7.5, invoiceAmount: 75, purchaseDate: DateTime(2026, 4, 3), receivedDate: DateTime(2026, 4, 5)),
  ProcurementItem(id: '4', name: 'LED Strip', category: 'Sign Post', vendor: 'Bright Lights Co', unitCost: 4.5, invoiceAmount: 45, purchaseDate: DateTime(2026, 4, 4), receivedDate: DateTime(2026, 4, 6)),
  ProcurementItem(id: '5', name: 'Steel Frame', category: 'Main Panel', vendor: 'SteelWorks Ltd', unitCost: 15, invoiceAmount: 150, purchaseDate: DateTime(2026, 4, 5), receivedDate: DateTime(2026, 4, 7)),
  ProcurementItem(id: '6', name: 'Glass Panel', category: 'Rider Panel', vendor: 'ClearView Glass', unitCost: 18, invoiceAmount: 180, purchaseDate: DateTime(2026, 4, 6), receivedDate: DateTime(2026, 4, 8)),
  ProcurementItem(id: '7', name: 'Vinyl Sticker Roll', category: 'Sign Post', vendor: 'PrintPro Supplies', unitCost: 6, invoiceAmount: 60, purchaseDate: DateTime(2026, 4, 7), receivedDate: DateTime(2026, 4, 9)),
  ProcurementItem(id: '8', name: 'Wooden Panel', category: 'Main Panel', vendor: 'Timber Mart', unitCost: 11, invoiceAmount: 110, purchaseDate: DateTime(2026, 4, 8), receivedDate: DateTime(2026, 4, 10)),
  ProcurementItem(id: '9', name: 'Backlit Flex', category: 'Rider Panel', vendor: 'FlexPrint Ltd', unitCost: 8.5, invoiceAmount: 85, purchaseDate: DateTime(2026, 4, 9), receivedDate: DateTime(2026, 4, 11)),
  ProcurementItem(id: '10', name: 'LED Driver', category: 'Sign Post', vendor: 'PowerTech', unitCost: 5.5, invoiceAmount: 55, purchaseDate: DateTime(2026, 4, 10), receivedDate: DateTime(2026, 4, 12)),
];

/// -----------------------------------------------------------------------
/// SCREEN
/// -----------------------------------------------------------------------
class ProcurementScreen extends StatefulWidget {
  const ProcurementScreen({super.key});

  @override
  State<ProcurementScreen> createState() => _ProcurementScreenState();
}

class _ProcurementScreenState extends State<ProcurementScreen> {
  final List<ProcurementItem> _items = _seedData();
  final TextEditingController _searchCtrl = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;

  List<ProcurementItem> get _filtered {
    return _items.where((item) {
      final matchesSearch = _searchCtrl.text.trim().isEmpty ||
          item.name.toLowerCase().contains(_searchCtrl.text.trim().toLowerCase()) ||
          item.vendor.toLowerCase().contains(_searchCtrl.text.trim().toLowerCase());
      final matchesFrom = _fromDate == null || !item.purchaseDate.isBefore(_fromDate!);
      final matchesTo = _toDate == null || !item.purchaseDate.isAfter(_toDate!);
      return matchesSearch && matchesFrom && matchesTo;
    }).toList();
  }

  double get _totalExpense =>
      _filtered.fold<double>(0, (sum, item) => sum + item.invoiceAmount);

  // ---------------------------------------------------------------------
  // Open the Add/Edit dialog. Passing `existing` switches it into edit
  // mode: title becomes "Edit Procurement", primary button becomes
  // "Update", and every field is pre-filled from that item.
  // ---------------------------------------------------------------------
  Future<void> _openProcurementDialog({ProcurementItem? existing}) async {
    final result = await showDialog<ProcurementItem>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => ProcurementDialog(existing: existing),
    );

    if (result == null) return;

    setState(() {
      if (existing == null) {
        _items.insert(0, result);
      } else {
        final idx = _items.indexWhere((i) => i.id == existing.id);
        if (idx != -1) _items[idx] = result;
      }
    });
  }

  void _deleteItem(ProcurementItem item) {
    setState(() => _items.removeWhere((i) => i.id == item.id));
  }

  Future<void> _pickRangeDate({required bool isFrom}) async {
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
    final filtered = _filtered;

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
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(filtered.length),
                _buildTotalExpense(),
                const SizedBox(height: 4),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width - 40,
                      ),
                      child: _buildTable(filtered),
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
  // HEADER: title + total badge + date range filters + search + Add
  // ---------------------------------------------------------------------
  Widget _buildHeader(int total) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row 1: Title + total badge + Add button ──
          Row(
            children: [
              const Text(
                'Procurement',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 12),
              const Text('Total:', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.blueBadgeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$total',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.blue),
                ),
              ),
              const Spacer(),
              _addButton(),
            ],
          ),
          const SizedBox(height: 12),
          // ── Row 2: From · To · Search ──
          Row(
            children: [
              _rangeDateField(label: 'From:', value: _fromDate, onTap: () => _pickRangeDate(isFrom: true)),
              const SizedBox(width: 10),
              _rangeDateField(label: 'To:', value: _toDate, onTap: () => _pickRangeDate(isFrom: false)),
              const SizedBox(width: 10),
              Expanded(child: _searchField()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rangeDateField({required String label, required DateTime? value, required VoidCallback onTap}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              value == null ? 'mm/dd/yyyy' : fmtDialogDate(value),
              style: TextStyle(fontSize: 12.5, color: value == null ? AppColors.textMuted : AppColors.textPrimary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchField() {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(6),
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
                hintText: 'Search here...',
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

  Widget _addButton() {
    return ElevatedButton.icon(
      onPressed: () => _openProcurementDialog(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: const Icon(Icons.add, size: 17),
      label: const Text('Add', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }

  // ---------------------------------------------------------------------
  // TOTAL EXPENSE card
  // ---------------------------------------------------------------------
  Widget _buildTotalExpense() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(AppColors.radiusMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TOTAL EXPENSE',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.4),
            ),
            const SizedBox(height: 4),
            Text(
              fmtMoney(_totalExpense),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TABLE
  // ---------------------------------------------------------------------
  static const Map<String, int> _colFlex = {
    'sn': 3,
    'name': 12,
    'category': 10,
    'vendor': 12,
    'purchase': 11,
    'received': 11,
    'unit': 9,
    'invoice': 11,
    'action': 8,
  };

  Widget _buildTable(List<ProcurementItem> items) {
    return SizedBox(
      width: 1440,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _tableHeaderRow(),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text('No procurement records found.', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          _headerCell('S.N.', _colFlex['sn']!),
          _headerCell('Name', _colFlex['name']!),
          _headerCell('Category', _colFlex['category']!),
          _headerCell('Vendor', _colFlex['vendor']!),
          _headerCell('Purchase Date', _colFlex['purchase']!),
          _headerCell('Received Date', _colFlex['received']!),
          _headerCell('Unit Cost', _colFlex['unit']!),
          _headerCell('Invoice Amount', _colFlex['invoice']!),
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

  Widget _tableDataRow(int sn, ProcurementItem item) {
    final colors = categoryColors(item.category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.rowBorder)),
      ),
      child: Row(
        children: [
          _dataCell('$sn', _colFlex['sn']!, style: AppText.cellLink),
          _dataCell(item.name, _colFlex['name']!),
          Expanded(
            flex: _colFlex['category']!,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: colors.bg, borderRadius: BorderRadius.circular(20)),
                child: Text(item.category, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.text)),
              ),
            ),
          ),
          _dataCell(item.vendor, _colFlex['vendor']!, style: AppText.cellLink),
          _dataCell(fmtTableDate(item.purchaseDate), _colFlex['purchase']!),
          _dataCell(fmtTableDate(item.receivedDate), _colFlex['received']!),
          _dataCell(fmtMoney(item.unitCost), _colFlex['unit']!, style: AppText.cellLink),
          _dataCell(fmtMoney(item.invoiceAmount), _colFlex['invoice']!, style: AppText.cellLink),
          Expanded(
            flex: _colFlex['action']!,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _openProcurementDialog(existing: item),
                  child: const Icon(Icons.edit_outlined, size: 18, color: AppColors.iconEdit),
                ),
                const SizedBox(width: 14),
                GestureDetector(
                  onTap: () => _deleteItem(item),
                  child: const Icon(Icons.delete_outline, size: 18, color: AppColors.iconDelete),
                ),
              ],
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
}

/// -----------------------------------------------------------------------
/// ADD / EDIT DIALOG
///
/// A single widget handles both modes:
///  - `existing == null`  -> "Add Procurement", button says "Add"
///  - `existing != null`  -> "Edit Procurement", button says "Update",
///     and every field starts pre-filled from that item.
/// -----------------------------------------------------------------------
class ProcurementDialog extends StatefulWidget {
  final ProcurementItem? existing;
  const ProcurementDialog({super.key, this.existing});

  @override
  State<ProcurementDialog> createState() => _ProcurementDialogState();
}

class _ProcurementDialogState extends State<ProcurementDialog> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _vendorCtrl;
  late final TextEditingController _invoiceCtrl;
  late final TextEditingController _unitCostCtrl;

  String? _category;
  DateTime? _purchaseDate;
  DateTime? _receivedDate;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _nameCtrl = TextEditingController(text: existing?.name ?? '');
    _vendorCtrl = TextEditingController(text: existing?.vendor ?? '');
    _invoiceCtrl = TextEditingController(text: existing == null ? '' : _trimZero(existing.invoiceAmount));
    _unitCostCtrl = TextEditingController(text: existing == null ? '' : _trimZero(existing.unitCost));
    _category = existing?.category;
    _purchaseDate = existing?.purchaseDate;
    _receivedDate = existing?.receivedDate;
  }

  String _trimZero(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toString();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _vendorCtrl.dispose();
    _invoiceCtrl.dispose();
    _unitCostCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isPurchase}) async {
    final initial = (isPurchase ? _purchaseDate : _receivedDate) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      if (isPurchase) {
        _purchaseDate = picked;
      } else {
        _receivedDate = picked;
      }
    });
  }

  void _submit() {
    final name = _nameCtrl.text.trim();
    final vendor = _vendorCtrl.text.trim();
    final invoice = double.tryParse(_invoiceCtrl.text.trim()) ?? 0;
    final unitCost = double.tryParse(_unitCostCtrl.text.trim()) ?? 0;

    if (name.isEmpty || vendor.isEmpty || _category == null || _purchaseDate == null || _receivedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    final result = ProcurementItem(
      id: widget.existing?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      category: _category!,
      vendor: vendor,
      unitCost: unitCost,
      invoiceAmount: invoice,
      purchaseDate: _purchaseDate!,
      receivedDate: _receivedDate!,
    );

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppColors.radiusLg)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isEdit ? 'Edit Procurement' : 'Add Procurement',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, size: 20, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const Divider(height: 24, color: AppColors.border),
              _fieldLabel('Name'),
              _textField(_nameCtrl, hint: 'Type here..'),
              const SizedBox(height: 14),
              _fieldLabel('Category'),
              _categoryDropdown(),
              const SizedBox(height: 14),
              _fieldLabel('Vendor Name'),
              _textField(_vendorCtrl, hint: 'Type here..'),
              const SizedBox(height: 14),
              _fieldLabel('Invoice Amount'),
              _textField(_invoiceCtrl, hint: 'Enter price', isNumber: true),
              const SizedBox(height: 14),
              _fieldLabel('Unit Cost'),
              _textField(_unitCostCtrl, hint: 'Enter cost', isNumber: true),
              const SizedBox(height: 14),
              _fieldLabel('Purchase Date'),
              _dateField(_purchaseDate, () => _pickDate(isPurchase: true)),
              const SizedBox(height: 14),
              _fieldLabel('Received Date'),
              _dateField(_receivedDate, () => _pickDate(isPurchase: false)),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        side: BorderSide.none,
                        backgroundColor: AppColors.fieldFill,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Close', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      // This is the key behavior requested: same dialog,
                      // but the label reflects Add vs. Edit mode.
                      child: Text(_isEdit ? 'Update' : 'Add', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
  );

  Widget _textField(TextEditingController controller, {required String hint, bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: AppColors.textMuted),
        filled: true,
        fillColor: AppColors.fieldFill,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1.4)),
      ),
    );
  }

  Widget _categoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(color: AppColors.fieldFill, borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _category,
          isExpanded: true,
          hint: const Text('Select a category', style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
          items: kCategories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: (value) => setState(() => _category = value),
        ),
      ),
    );
  }

  Widget _dateField(DateTime? value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(color: AppColors.fieldFill, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value == null ? 'mm/dd/yyyy' : fmtDialogDate(value),
                style: TextStyle(fontSize: 13, color: value == null ? AppColors.textMuted : AppColors.textPrimary),
              ),
            ),
            const Icon(Icons.calendar_today_outlined, size: 15, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}