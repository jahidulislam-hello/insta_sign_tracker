import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Brokerage {
  String name;
  Brokerage(this.name);
}

class BrokeragePage extends StatefulWidget {
  const BrokeragePage({super.key});

  @override
  State<BrokeragePage> createState() => _BrokeragePageState();
}

class _BrokeragePageState extends State<BrokeragePage> {
  final List<Brokerage> _brokerages = [
    Brokerage('Keller Williams'),
    Brokerage('RE/MAX'),
    Brokerage('John Doe'),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  List<Brokerage> get _filtered => _query.isEmpty
      ? _brokerages
      : _brokerages
      .where((b) => b.name.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  // ---------- Dialog logic ----------

  Future<void> _openAddDialog() async {
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const BrokerageDialog(isEdit: false),
    );
    if (result != null && result.trim().isNotEmpty) {
      setState(() => _brokerages.add(Brokerage(result.trim())));
    }
  }

  Future<void> _openEditDialog(Brokerage brokerage) async {
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => BrokerageDialog(isEdit: true, initialName: brokerage.name),
    );
    if (result != null && result.trim().isNotEmpty) {
      setState(() => brokerage.name = result.trim());
    }
  }

  void _deleteBrokerage(Brokerage brokerage) {
    setState(() => _brokerages.remove(brokerage));
  }

  // ---------- UI ----------

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
                      'No brokerages found',
                      style: TextStyle(color: Color(0xFF9CA3AF)),
                    ),
                  ),
                )
                    : ListView.separated(
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Color(0xFFF0F1F3)),
                  itemBuilder: (context, index) {
                    final brokerage = _filtered[index];
                    return _buildRow(index + 1, brokerage);
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
          'Brokerage',
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
            '${_brokerages.length}',
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
        ElevatedButton(
          onPressed: _openAddDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F9BFF),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Add Brokerage',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
            width: 80,
            child: Text('S.N.',
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1F2937))),
          ),
          Expanded(
            child: Text('Name',
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

  Widget _buildRow(int sn, Brokerage brokerage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text('$sn',
                style: const TextStyle(fontSize: 14, color: Color(0xFF2F6FED))),
          ),
          Expanded(
            child: Text(brokerage.name,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937))),
          ),
          SizedBox(
            width: 100,
            child: Row(
              children: [
                InkWell(
                  onTap: () => _openEditDialog(brokerage),
                  borderRadius: BorderRadius.circular(4),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.edit_outlined, size: 18, color: Color(0xFF22C55E)),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _deleteBrokerage(brokerage),
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

// ==============================================================
// Add / Edit Brokerage Dialog (same widget, driven by isEdit flag)
// ==============================================================

class BrokerageDialog extends StatefulWidget {
  final bool isEdit;
  final String? initialName;

  const BrokerageDialog({super.key, required this.isEdit, this.initialName});

  @override
  State<BrokerageDialog> createState() => _BrokerageDialogState();
}

class _BrokerageDialogState extends State<BrokerageDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEdit ? 'Edit Brokerage' : 'Add Brokerage';
    final actionLabel = widget.isEdit ? 'Update' : 'Add';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetAnimationDuration: const Duration(milliseconds: 150),
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
              'Name',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2F6FED),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              autofocus: true,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Type here..',
                hintStyle: const TextStyle(color: Color(0xFFB0B4BA), fontSize: 14),
                filled: true,
                fillColor: const Color(0xFFF3F4F7),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
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
                      if (_controller.text.trim().isEmpty) return;
                      Navigator.of(context).pop(_controller.text.trim());
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
}