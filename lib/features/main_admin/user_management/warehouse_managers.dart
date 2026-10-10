
import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


// ----------------------------- MODEL -----------------------------

class WarehouseManager {
  String name;
  String email;
  String phone;
  String joinDate;
  String warehouse;
  String role;

  WarehouseManager({
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
    this.warehouse = 'Warehouse-01',
    this.role = 'Warehouse manger',
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}

// ----------------------------- MAIN PAGE -----------------------------

class WarehouseManagersPage extends StatefulWidget {
  const WarehouseManagersPage({super.key});

  @override
  State<WarehouseManagersPage> createState() => _WarehouseManagersPageState();
}

class _WarehouseManagersPageState extends State<WarehouseManagersPage> {
  final List<WarehouseManager> _managers = [
    WarehouseManager(
      name: 'Noah Martinez',
      email: 'noah@gmail.com',
      phone: '+880171234566',
      joinDate: '02/13/2026',
    ),
  ];

  final List<String> _warehouseOptions = const [
    'Warehouse-01',
    'Warehouse-02',
    'Warehouse-03',
  ];

  final TextEditingController _searchController = TextEditingController();
  List<WarehouseManager> get _filtered {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return _managers;
    return _managers
        .where((m) =>
    m.name.toLowerCase().contains(q) ||
        m.email.toLowerCase().contains(q))
        .toList();
  }

  // ---------- Dialog launchers ----------

  void _openAdd() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => WarehouseManagerFormDialog(
        isEdit: false,
        warehouseOptions: _warehouseOptions,
        onSubmit: (name, email, phone, warehouse) {
          setState(() {
            _managers.add(WarehouseManager(
              name: name,
              email: email,
              phone: phone,
              joinDate: _todayString(),
              warehouse: warehouse,
            ));
          });
        },
      ),
    );
  }

  void _openEdit(WarehouseManager m) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => WarehouseManagerFormDialog(
        isEdit: true,
        initial: m,
        warehouseOptions: _warehouseOptions,
        onSubmit: (name, email, phone, warehouse) {
          setState(() {
            m.name = name;
            m.email = email;
            m.phone = phone;
            m.warehouse = warehouse;
          });
        },
      ),
    );
  }

  void _openView(WarehouseManager m) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => ViewWarehouseManagerDialog(manager: m),
    );
  }

  void _delete(WarehouseManager m) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete warehouse manager?'),
        content: Text('Remove ${m.name} from the list?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() => _managers.remove(m));
              Navigator.pop(ctx);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _todayString() {
    final now = DateTime.now();
    return '${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}/${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
                const Divider(height: 1, color: AppColors.border),
                Expanded(
                  child: _filtered.isEmpty
                      ? const Center(
                      child: Text('No warehouse managers found',
                          style: TextStyle(color: AppColors.textSecondary)))
                      : ListView.separated(
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const Divider(
                        height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final m = _filtered[index];
                      return _buildRow(index + 1, m);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Text(
          'Warehouse Managers',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(width: 10),
        const Text('Total: ', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.headerBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text('${_managers.length}',
              style: const TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 12)),
        ),
        const Spacer(),
        SizedBox(
          width: 260,
          height: 40,
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search here...',
              hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
              prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.inputFill,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: _openAdd,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Warehouse Manager'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    const style = TextStyle(
        fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textPrimary);
    return Container(
      color: AppColors.headerBg,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: const Row(
        children: [
          SizedBox(width: 40, child: Text('S.N', style: style)),
          Expanded(flex: 3, child: Text('Name', style: style)),
          Expanded(flex: 3, child: Text('Email', style: style)),
          Expanded(flex: 2, child: Text('Phone', style: style)),
          Expanded(flex: 2, child: Text('Join Date', style: style)),
          SizedBox(width: 90, child: Text('Action', style: style)),
        ],
      ),
    );
  }

  Widget _buildRow(int sn, WarehouseManager m) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          SizedBox(
              width: 40,
              child: Text('$sn',
                  style: const TextStyle(color: AppColors.emailText, fontSize: 13))),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFFE3E6EA),
                  child: const Icon(Icons.person, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(m.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(m.email,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: AppColors.emailText)),
          ),
          Expanded(
            flex: 2,
            child: Text(m.phone,
                style: const TextStyle(fontSize: 13, color: AppColors.emailText)),
          ),
          Expanded(
            flex: 2,
            child: Text(m.joinDate,
                style: const TextStyle(fontSize: 13, color: AppColors.emailText)),
          ),
          SizedBox(
            width: 90,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _openView(m),
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  color: AppColors.textSecondary,
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => _openEdit(m),
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  color: AppColors.editGreen,
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => _delete(m),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  color: AppColors.deleteRed,
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------- DIALOG SHELL -----------------------------

/// Common rounded modal container used by all dialogs, matching the
/// grey-bordered card look from the screenshots.
class DialogShell extends StatelessWidget {
  final double width;
  final Widget child;
  const DialogShell({super.key, required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        width: width,
        constraints: const BoxConstraints(maxHeight: 620),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF9AA1AC), width: 1.5),
        ),
        child: child,
      ),
    );
  }
}

// ----------------------------- VIEW DIALOG -----------------------------

class ViewWarehouseManagerDialog extends StatelessWidget {
  final WarehouseManager manager;
  const ViewWarehouseManagerDialog({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return DialogShell(
      width: 380,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, size: 20),
                splashRadius: 18,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            CircleAvatar(
              radius: 34,
              backgroundColor: AppColors.blue,
              child: Text(
                manager.initials,
                style: const TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),
            Text(manager.name,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(manager.role,
                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            const Divider(color: AppColors.border),
            const SizedBox(height: 8),
            _iconRow(Icons.mail_outline, manager.email),
            const SizedBox(height: 10),
            _iconRow(Icons.call_outlined, manager.phone),
            const SizedBox(height: 14),
            const Divider(color: AppColors.border),
            const SizedBox(height: 8),
            _statRow('WAREHOUSE', manager.warehouse),
          ],
        ),
      ),
    );
  }

  Widget _iconRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  Widget _statRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w500)),
          Text(value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

// ----------------------------- ADD / EDIT DIALOG -----------------------------

typedef WarehouseManagerSubmitCallback = void Function(
    String name, String email, String phone, String warehouse);

class WarehouseManagerFormDialog extends StatefulWidget {
  final bool isEdit;
  final WarehouseManager? initial;
  final List<String> warehouseOptions;
  final WarehouseManagerSubmitCallback onSubmit;

  const WarehouseManagerFormDialog({
    super.key,
    required this.isEdit,
    this.initial,
    required this.warehouseOptions,
    required this.onSubmit,
  });

  @override
  State<WarehouseManagerFormDialog> createState() =>
      _WarehouseManagerFormDialogState();
}

class _WarehouseManagerFormDialogState
    extends State<WarehouseManagerFormDialog> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  String? _warehouse;

  @override
  void initState() {
    super.initState();
    final m = widget.initial;
    _nameCtrl = TextEditingController(text: m?.name ?? '');
    _emailCtrl = TextEditingController(text: m?.email ?? '');
    _phoneCtrl = TextEditingController(text: m?.phone ?? '');
    _warehouse = m?.warehouse ??
        (widget.warehouseOptions.isNotEmpty ? null : null);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameCtrl.text.trim().isEmpty || _emailCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and Email are required')),
      );
      return;
    }
    if (_warehouse == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a warehouse')),
      );
      return;
    }
    widget.onSubmit(
      _nameCtrl.text.trim(),
      _emailCtrl.text.trim(),
      _phoneCtrl.text.trim(),
      _warehouse!,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEdit ? 'Edit Warehouse Manager' : 'Add Warehouse Manager';
    final submitLabel = widget.isEdit ? 'Save Changes' : 'Add';
    final selectLabel = widget.isEdit ? 'Select Warehouse' : 'Select Warehouse';

    return DialogShell(
      width: 380,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 20),
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _label('Name'),
            _field(_nameCtrl, 'Type here..'),
            const SizedBox(height: 12),
            _label('Email'),
            _field(_emailCtrl, 'Type here..'),
            const SizedBox(height: 12),
            _label('Phone'),
            _field(_phoneCtrl, 'Type here..'),
            const SizedBox(height: 12),
            _label(selectLabel),
            _dropdown(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.blue,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(submitLabel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
  );

  Widget _field(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        filled: true,
        fillColor: AppColors.inputFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _warehouse,
          isExpanded: true,
          hint: const Text('Select Warehouse',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
          items: widget.warehouseOptions
              .map((w) => DropdownMenuItem(value: w, child: Text(w)))
              .toList(),
          onChanged: (v) => setState(() => _warehouse = v),
        ),
      ),
    );
  }
}