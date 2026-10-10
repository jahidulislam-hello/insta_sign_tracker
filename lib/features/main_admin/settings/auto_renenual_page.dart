
import 'package:flutter/material.dart';

class AutoRenew {
  String days;
  String price;
  bool isOn;

  AutoRenew({required this.days, required this.price, this.isOn = false});
}

class AutoRenewalPage extends StatefulWidget {
  const AutoRenewalPage({super.key});

  @override
  State<AutoRenewalPage> createState() => _AutoRenewalPageState();
}

class _AutoRenewalPageState extends State<AutoRenewalPage> {
  final List<AutoRenew> _renewals = [
    AutoRenew(days: '90 Days', price: '\$1200', isOn: true),
    AutoRenew(days: '120 Days', price: '\$1500', isOn: false),
    AutoRenew(days: '150 Days', price: '\$2000', isOn: false),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  List<AutoRenew> get _filtered => _query.isEmpty
      ? _renewals
      : _renewals.where((r) => r.days.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openAddDialog() async {
    final result = await showDialog<AutoRenew>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const AutoRenewDialog(isEdit: false),
    );
    if (result != null) {
      setState(() => _renewals.add(result));
    }
  }

  Future<void> _openEditDialog(AutoRenew renew) async {
    final result = await showDialog<AutoRenew>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => AutoRenewDialog(isEdit: true, existing: renew),
    );
    if (result != null) {
      setState(() {
        renew.days = result.days;
        renew.price = result.price;
      });
    }
  }

  void _deleteRenew(AutoRenew renew) {
    setState(() => _renewals.remove(renew));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTableHeader(),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
              Expanded(
                child: _filtered.isEmpty
                    ? const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'No auto renewals found',
                      style: TextStyle(color: Color(0xFF9CA3AF)),
                    ),
                  ),
                )
                    : ListView.separated(
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Color(0xFFF0F1F3)),
                  itemBuilder: (context, index) {
                    final renew = _filtered[index];
                    return _buildRow(index + 1, renew);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Auto Renewal',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Total:',
          style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF2FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${_renewals.length}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2F6FED),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 260,
          height: 40,
          child: TextField(
            controller: _searchController,
            onChanged: (v) => setState(() => _query = v),
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search here...',
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              prefixIcon: const Icon(Icons.search, size: 20, color: Color(0xFF9CA3AF)),
              filled: true,
              fillColor: const Color(0xFFF3F4F7),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: _openAddDialog,
          icon: const Icon(Icons.add, size: 18, color: Colors.white),
          label: const Text(
            'Add Renew',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F9BFF),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: const Color(0xFFEAF2FF),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: const Row(
        children: [
          SizedBox(
            width: 60,
            child: Text('S.N.',
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
          ),
          Expanded(
            flex: 2,
            child: Text('Days',
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
          ),
          Expanded(
            flex: 2,
            child: Text('Price',
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
          ),
          Expanded(
            flex: 2,
            child: Text('Status',
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
          ),
          SizedBox(
            width: 100,
            child: Text('Action',
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(int sn, AutoRenew renew) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text('$sn',
                style: const TextStyle(fontSize: 14, color: Color(0xFFF5A623))),
          ),
          Expanded(
            flex: 2,
            child: Text(renew.days,
                style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
          ),
          Expanded(
            flex: 2,
            child: Text(renew.price,
                style: const TextStyle(fontSize: 14, color: Color(0xFF2F6FED))),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  renew.isOn ? 'On' : 'Off',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                ),
                const SizedBox(width: 8),
                Transform.scale(
                  scale: 0.85,
                  child: Switch(
                    value: renew.isOn,
                    onChanged: (v) => setState(() => renew.isOn = v),
                    activeColor: Colors.white,
                    activeTrackColor: const Color(0xFF2F9BFF),
                    inactiveThumbColor: Colors.black,
                    inactiveTrackColor: const Color(0xFFD1D5DB),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              children: [
                InkWell(
                  onTap: () => _openEditDialog(renew),
                  borderRadius: BorderRadius.circular(4),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.edit_outlined, size: 18, color: Color(0xFF22C55E)),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _deleteRenew(renew),
                  borderRadius: BorderRadius.circular(4),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.delete_outline, size: 18, color: Color(0xFFEF4444)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// Add / Edit Auto Renew Dialog (shared widget, driven by isEdit flag)
// ==================================================================

class AutoRenewDialog extends StatefulWidget {
  final bool isEdit;
  final AutoRenew? existing;

  const AutoRenewDialog({super.key, required this.isEdit, this.existing});

  @override
  State<AutoRenewDialog> createState() => _AutoRenewDialogState();
}

class _AutoRenewDialogState extends State<AutoRenewDialog> {
  late final TextEditingController _daysController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _daysController = TextEditingController(
        text: widget.existing != null ? widget.existing!.days.replaceAll(' Days', '') : '');
    _priceController = TextEditingController(
        text: widget.existing != null ? widget.existing!.price.replaceAll('\$', '') : '');
  }

  @override
  void dispose() {
    _daysController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEdit ? 'Edit Renew' : 'Add Auto Renew';
    final actionLabel = widget.isEdit ? 'Update' : 'Add';

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 380,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, size: 20, color: Color(0xFF6B7280)),
                ),
              ],
            ),
            const SizedBox(height: 18),

            const Text(
              'Select Days',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _daysController,
              autofocus: true,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 14),
              decoration: _fieldDecoration('Enter days'),
            ),
            const SizedBox(height: 18),

            const Text(
              'Price',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 14),
              decoration: _fieldDecoration('Enter price'),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2F9BFF),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Close',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final days = _daysController.text.trim();
                      final price = _priceController.text.trim();
                      if (days.isEmpty || price.isEmpty) return;
                      Navigator.of(context).pop(
                        AutoRenew(
                          days: '$days Days',
                          price: '\$$price',
                          isOn: widget.existing?.isOn ?? false,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F9BFF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(actionLabel,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFB0B4BA), fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF3F4F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}