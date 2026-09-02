
import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


// ----------------------------- MODEL -----------------------------

class Office {
  String name;
  String email;
  String phone;
  String joinDate;
  String office;
  String brokerage;
  String role;
  int totalOrders;
  int totalAgent;
  int inventoryItems;

  Office({
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
    this.office = 'Real estate office',
    this.brokerage = 'Brokerage Office',
    this.role = 'Team Lead',
    this.totalOrders = 50,
    this.totalAgent = 10,
    this.inventoryItems = 100,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}

// ----------------------------- MAIN PAGE -----------------------------

class OfficeManagerPage extends StatefulWidget {
  const OfficeManagerPage({super.key});

  @override
  State<OfficeManagerPage> createState() => _OfficeManagerPageState();
}

class _OfficeManagerPageState extends State<OfficeManagerPage> {
  final List<Office> _offices = [
    Office(
      name: 'Michael Brown',
      email: 'michael@gmail.com',
      phone: '+880171234569',
      joinDate: '02/18/2026',
    ),
    Office(
      name: 'James Wilson',
      email: 'james@gmail.com',
      phone: '+880171234563',
      joinDate: '02/15/2026',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Office> get _filtered {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return _offices;
    return _offices
        .where((o) =>
    o.name.toLowerCase().contains(q) ||
        o.email.toLowerCase().contains(q))
        .toList();
  }

  // ---------- Dialog launchers ----------

  void _openAddOffice() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => OfficeFormDialog(
        isEdit: false,
        onSubmit: (name, email, phone, office, brokerage) {
          setState(() {
            _offices.add(Office(
              name: name,
              email: email,
              phone: phone,
              joinDate: _todayString(),
              office: office,
              brokerage: brokerage,
            ));
          });
        },
      ),
    );
  }

  void _openEditOffice(Office o) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => OfficeFormDialog(
        isEdit: true,
        initial: o,
        onSubmit: (name, email, phone, office, brokerage) {
          setState(() {
            o.name = name;
            o.email = email;
            o.phone = phone;
            o.office = office;
            o.brokerage = brokerage;
          });
        },
      ),
    );
  }

  void _openView(Office o) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => ViewOfficeDialog(office: o),
    );
  }

  void _openCreateOrder(Office o) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => CreateOrderDialog(office: o),
    );
  }

  void _deleteOffice(Office o) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete office?'),
        content: Text('Remove ${o.name} from the list?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() => _offices.remove(o));
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
                      child: Text('No offices found',
                          style: TextStyle(color: AppColors.textSecondary)))
                      : ListView.separated(
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const Divider(
                        height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final o = _filtered[index];
                      return _buildRow(index + 1, o);
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
          'Office Manager',
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
          child: Text('${_offices.length}',
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
          onPressed: _openAddOffice,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Office'),
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
          Expanded(flex: 2, child: Text('Create Order', style: style)),
          SizedBox(width: 90, child: Text('Action', style: style)),
        ],
      ),
    );
  }

  Widget _buildRow(int sn, Office o) {
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
                  child: Text(o.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(o.email,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: AppColors.emailText)),
          ),
          Expanded(
            flex: 2,
            child: Text(o.phone,
                style: const TextStyle(fontSize: 13, color: AppColors.emailText)),
          ),
          Expanded(
            flex: 2,
            child: Text(o.joinDate,
                style: const TextStyle(fontSize: 13, color: AppColors.emailText)),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 34,
              width: 130,
              child: ElevatedButton(
                onPressed: () => _openCreateOrder(o),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Create Order', style: TextStyle(fontSize: 12.5)),
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _openView(o),
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  color: AppColors.textSecondary,
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => _openEditOffice(o),
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  color: AppColors.editGreen,
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => _deleteOffice(o),
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

// ----------------------------- CREATE ORDER DIALOG -----------------------------

class CreateOrderDialog extends StatelessWidget {
  final Office office;
  const CreateOrderDialog({super.key, required this.office});

  @override
  Widget build(BuildContext context) {
    return DialogShell(
      width: 700,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
            child: Row(
              children: [
                const Text('Create Order',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const Spacer(),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: const Color(0xFFE3E6EA),
                  child: const Icon(Icons.person, size: 12, color: Colors.white),
                ),
                const SizedBox(width: 6),
                Text(office.name,
                    style: const TextStyle(
                        color: AppColors.blue, fontWeight: FontWeight.w600)),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 20),
                  splashRadius: 18,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _OrderColumn(
                    title: 'For Sale Signs',
                    items: const [
                      _OrderItem('🏠', 'Order New Sign Install'),
                      _OrderItem('🖨️', 'Order Sign Printing'),
                      _OrderItem('✕', 'Order Sign Removal', iconBg: Color(0xFFEB4B4B), isDanger: true),
                      _OrderItem('🔁', 'Change Request'),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _OrderColumn(
                    title: 'Other Services',
                    items: const [
                      _OrderItem('🚩', 'Order For Sale Directionals'),
                      _OrderItem('🏡', 'Order Open House Services'),
                      _OrderItem('📷', 'Order Media Services'),
                      _OrderItem('🧰', 'Other Services', badge: 'NEW'),
                    ],
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

class _OrderItem {
  final String emoji;
  final String label;
  final String? badge;
  final Color? iconBg;
  final bool isDanger;
  const _OrderItem(this.emoji, this.label,
      {this.badge, this.iconBg, this.isDanger = false});
}

class _OrderColumn extends StatelessWidget {
  final String title;
  final List<_OrderItem> items;
  const _OrderColumn({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: item.isDanger
                          ? const Color(0xFFEB4B4B)
                          : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: item.isDanger
                        ? const Icon(Icons.close, color: Colors.white, size: 16)
                        : Text(item.emoji, style: const TextStyle(fontSize: 15)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(item.label,
                        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500)),
                  ),
                  if (item.badge != null)
                    Container(
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3E6EA),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(item.badge!,
                          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700)),
                    ),
                  const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }
}

// ----------------------------- VIEW OFFICE DIALOG -----------------------------

class ViewOfficeDialog extends StatelessWidget {
  final Office office;
  const ViewOfficeDialog({super.key, required this.office});

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
                office.initials,
                style: const TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),
            Text(office.name,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(office.role,
                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            const Divider(color: AppColors.border),
            const SizedBox(height: 8),
            _iconRow(Icons.mail_outline, office.email),
            const SizedBox(height: 10),
            _iconRow(Icons.call_outlined, office.phone),
            const SizedBox(height: 14),
            const Divider(color: AppColors.border),
            const SizedBox(height: 8),
            _statRow('TOTAL ORDERS', '${office.totalOrders}'),
            _statRow('TOTAL AGENT', '${office.totalAgent}'),
            _statRow('INVENTORY ITEMS', '${office.inventoryItems}'),
            _statRow('OFFICE', office.office),
            _statRow('BROKERAGE', office.brokerage),
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
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ----------------------------- ADD / EDIT OFFICE DIALOG -----------------------------

typedef OfficeSubmitCallback = void Function(
    String name, String email, String phone, String office, String brokerage);

class OfficeFormDialog extends StatefulWidget {
  final bool isEdit;
  final Office? initial;
  final OfficeSubmitCallback onSubmit;

  const OfficeFormDialog({
    super.key,
    required this.isEdit,
    this.initial,
    required this.onSubmit,
  });

  @override
  State<OfficeFormDialog> createState() => _OfficeFormDialogState();
}

class _OfficeFormDialogState extends State<OfficeFormDialog> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _officeCtrl;
  String? _brokerage;

  final List<String> _brokerageOptions = const [
    'Brokerage Office',
    'Downtown Brokerage',
    'North Brokerage',
  ];

  @override
  void initState() {
    super.initState();
    final o = widget.initial;
    _nameCtrl = TextEditingController(text: o?.name ?? '');
    _emailCtrl = TextEditingController(text: o?.email ?? '');
    _phoneCtrl = TextEditingController(text: o?.phone ?? '');
    _officeCtrl = TextEditingController(text: o?.office ?? '');
    _brokerage = o?.brokerage ?? _brokerageOptions.first;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _officeCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameCtrl.text.trim().isEmpty || _emailCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name and Email are required')),
      );
      return;
    }
    widget.onSubmit(
      _nameCtrl.text.trim(),
      _emailCtrl.text.trim(),
      _phoneCtrl.text.trim(),
      _officeCtrl.text.trim(),
      _brokerage ?? _brokerageOptions.first,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEdit ? 'Edit Office' : 'Add Office';
    final submitLabel = widget.isEdit ? 'Save Changes' : 'Add';

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
                Text(title,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                const Spacer(),
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
            _label('Office'),
            _field(_officeCtrl, 'Type here..'),
            const SizedBox(height: 12),
            _label('Brokerage'),
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
          value: _brokerage,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
          items: _brokerageOptions
              .map((b) => DropdownMenuItem(value: b, child: Text(b)))
              .toList(),
          onChanged: (v) => setState(() => _brokerage = v),
        ),
      ),
    );
  }
}