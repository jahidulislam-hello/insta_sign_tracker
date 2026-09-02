
import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';



/// =========================================================================
/// CONSTANTS
/// =========================================================================
const String kAllTab = 'All';

const List<String> kOrderTypes = [
  'Installation',
  'Sign Printing',
  'Removal',
  'Sign Change',
  'For Sale Directionals',
  'Open House Services',
  'Media Services',
  'Other Services',
];

const List<String> kInstallers = [
  'Michael Johnson',
  'Sarah Williams',
  'David Roberts',
  'Sofia Turner',
];

/// The 7 states offered by the "Change Status" popup, each with its own
/// solid button color (matches the screenshot exactly).
const List<Map<String, dynamic>> kStatusActions = [
  {'label': 'Waiting on Payment', 'result': 'Waiting on Payment', 'color': Color(0xFF6E7686)},
  {'label': 'Mark As In Production', 'result': 'In Production', 'color': Color(0xFF22B8D8)},
  {'label': 'Mark As Ready', 'result': 'Ready', 'color': Color(0xFF7ED321)},
  {'label': 'Mark As Out for Delivery', 'result': 'Out for Delivery', 'color': Color(0xFF2F9BFF)},
  {'label': 'Mark As Delivered', 'result': 'Delivered', 'color': Color(0xFF0B5E3C)},
  {'label': 'Mark As Completed', 'result': 'Completed', 'color': Color(0xFF16C79A)},
  {'label': 'Mark As Cancelled', 'result': 'Cancelled', 'color': Color(0xFFFF6B1A)},
];

/// =========================================================================
/// MODEL
/// =========================================================================
class OrderRecord {
  final String id;
  String type;
  String address;
  String agent;
  String? technician;
  DateTime orderDate;
  DateTime dueDate;
  int daysInField;
  double price;
  String status;
  String assignment; // badge shown in the Order Details modal header

  // Order-details-modal-only fields
  final String detailOrderId;
  final String unitNumber;
  final String listingId;
  final String occupant;
  final String note;
  final String propertyType;
  final String signPlacement;
  final String gateCode;
  final String addressAccurate;
  final String lockbox;
  final List<String> siteWarnings;
  final List<String> addOnServices;
  final String postType;
  final String installType;
  final String riderSize;
  final String riderMaterial;
  final String mainPanelSize;
  final String mainPanelMaterial;

  OrderRecord({
    required this.id,
    required this.type,
    required this.address,
    required this.agent,
    required this.technician,
    required this.orderDate,
    required this.dueDate,
    required this.daysInField,
    required this.price,
    required this.status,
    required this.assignment,
    required this.detailOrderId,
    required this.unitNumber,
    required this.listingId,
    required this.occupant,
    required this.note,
    required this.propertyType,
    required this.signPlacement,
    required this.gateCode,
    required this.addressAccurate,
    required this.lockbox,
    required this.siteWarnings,
    required this.addOnServices,
    required this.postType,
    required this.installType,
    required this.riderSize,
    required this.riderMaterial,
    required this.mainPanelSize,
    required this.mainPanelMaterial,
  });
}

/// =========================================================================
/// FORMATTING / COLOR HELPERS
/// =========================================================================
String _2(int n) => n.toString().padLeft(2, '0');
String fmtDate(DateTime d) => '${_2(d.day)}/${_2(d.month)}/${d.year}';
String fmtDialogDate(DateTime d) => '${_2(d.month)}/${_2(d.day)}/${d.year}';
String fmtMoney(double v) => '\$${v.toStringAsFixed(2)}';

({Color bg, Color text}) typeColors(String type) {
  const palette = [
    (bg: AppColors.lightBlueBg, text: AppColors.primaryBlue), // Installation
    (bg: AppColors.redLight, text: AppColors.redSoft), // Removal
    (bg: AppColors.totalBadgeBgAlt, text: AppColors.totalBadgeTextAlt), // Sign Printing
    (bg: AppColors.orangeLight, text: AppColors.orange), // Sign Change
    (bg: AppColors.greenLight, text: AppColors.green), // For Sale Directionals
    (bg: AppColors.blueBadgeBg, text: AppColors.blue), // Open House Services
    (bg: AppColors.photographerBg, text: AppColors.photographerText), // Media Services
    (bg: AppColors.fieldFill, text: AppColors.textSecondary), // Other Services
  ];
  switch (type) {
    case 'Installation':
      return palette[0];
    case 'Removal':
      return palette[1];
    case 'Sign Printing':
      return palette[2];
    case 'Sign Change':
      return palette[3];
    case 'For Sale Directionals':
      return palette[4];
    case 'Open House Services':
      return palette[5];
    case 'Media Services':
      return palette[6];
    default:
      return palette[7];
  }
}

({Color bg, Color text}) statusColors(String status) {
  const grey = (bg: AppColors.fieldFill, text: AppColors.textSecondary);
  const amber = (bg: Color(0xFFFFF3CD), text: Color(0xFF8A6D00));
  const blue = (bg: AppColors.lightBlueBg, text: AppColors.primaryBlue);
  const purple = (bg: AppColors.totalBadgeBgAlt, text: AppColors.totalBadgeTextAlt);
  const lavender = (bg: AppColors.blueBadgeBg, text: AppColors.blue);
  const green = (bg: AppColors.greenLight, text: AppColors.green);
  const red = (bg: AppColors.redLight, text: AppColors.coralRed);
  const orange = (bg: AppColors.orangeLight, text: AppColors.orange);
  const cyan = (bg: Color(0xFFE0F7FA), text: Color(0xFF00ACC1));
  const lime = (bg: Color(0xFFF1F8E9), text: Color(0xFF7CB342));
  const darkGreen = (bg: Color(0xFFE6F4EA), text: Color(0xFF1B5E20));
  const teal = (bg: AppColors.greenLight, text: AppColors.green);

  switch (status) {
    case 'Waiting on Payment':
      return grey;
    case 'On Hold':
      return amber;
    case 'Pending Up':
    case 'Pending Down':
      return blue;
    case 'Scheduled Up':
    case 'Scheduled Down':
      return purple;
    case 'Assigned Up':
    case 'Assigned Down':
      return lavender;
    case 'Installed':
      return green;
    case 'Removed':
      return red;
    case 'Cancelled':
      return orange;
    case 'In Production':
      return cyan;
    case 'Ready':
      return lime;
    case 'Out for Delivery':
      return blue;
    case 'Delivered':
      return darkGreen;
    case 'Completed':
      return teal;
    default:
      return grey;
  }
}

/// =========================================================================
/// MOCK DATA — 12 rows match the screenshot exactly, the remaining 49 are
/// generated so "Total: 61" / pagination behave the same way as the design.
/// =========================================================================
List<OrderRecord> _seedOrders() {
  OrderRecord base({
    required String id,
    required String type,
    required String address,
    required String agent,
    String? technician,
    required DateTime orderDate,
    required DateTime dueDate,
    required int days,
    required double price,
    required String status,
  }) {
    return OrderRecord(
      id: id,
      type: type,
      address: address,
      agent: agent,
      technician: technician,
      orderDate: orderDate,
      dueDate: dueDate,
      daysInField: days,
      price: price,
      status: status,
      assignment: technician == null ? 'Unassigned' : 'Assigned',
      detailOrderId: '#124544',
      unitNumber: '203',
      listingId: '50',
      occupant: 'Nim Sujon',
      note: 'Please Install The Post As Soon As Possible',
      propertyType: 'Duplex',
      signPlacement: 'In Front Of The House',
      gateCode: 'In Front Of The House',
      addressAccurate: 'Accurate',
      lockbox: '24564556',
      siteWarnings: const ['Underground sprinkler system', 'Restricted/gated access'],
      addOnServices: const ['Underground sprinkler system', 'Restricted/gated access'],
      postType: '3 feet, Steel Metal Frame, Black',
      installType: 'Single Install',
      riderSize: '24×6',
      riderMaterial: 'ABS',
      mainPanelSize: '24×30',
      mainPanelMaterial: 'ABS',
    );
  }

  final orders = <OrderRecord>[
    base(id: '#8001', type: 'Installation', address: 'San Francisco, USA', agent: 'Liam Anderson', orderDate: DateTime(2026, 1, 11), dueDate: DateTime(2026, 1, 16), days: 5, price: 145, status: 'Waiting on Payment'),
    base(id: '#8003', type: 'Installation', address: 'Chicago, USA', agent: 'Emma Wilson', orderDate: DateTime(2026, 1, 9), dueDate: DateTime(2026, 1, 15), days: 6, price: 155, status: 'On Hold'),
    base(id: '#8002', type: 'Installation', address: 'Los Angeles, USA', agent: 'Noah Brown', orderDate: DateTime(2026, 1, 10), dueDate: DateTime(2026, 1, 15), days: 5, price: 150, status: 'Pending Up'),
    base(id: '#8004', type: 'Installation', address: 'Houston, USA', agent: 'Olivia Davis', orderDate: DateTime(2026, 1, 8), dueDate: DateTime(2026, 1, 14), days: 6, price: 160, status: 'Scheduled Up'),
    base(id: '#8005', type: 'Installation', address: 'Phoenix, USA', agent: 'James Miller', technician: 'Michael Johnson', orderDate: DateTime(2026, 1, 7), dueDate: DateTime(2026, 1, 12), days: 5, price: 165, status: 'Assigned Up'),
    base(id: '#8006', type: 'Installation', address: 'Dallas, USA', agent: 'Sophia Garcia', orderDate: DateTime(2026, 1, 6), dueDate: DateTime(2026, 1, 11), days: 5, price: 170, status: 'Installed'),
    base(id: '#8007', type: 'Installation', address: 'Seattle, USA', agent: 'Ethan Martinez', orderDate: DateTime(2026, 1, 5), dueDate: DateTime(2026, 1, 10), days: 5, price: 175, status: 'Cancelled'),
    base(id: '#8008', type: 'Removal', address: 'Miami, USA', agent: 'Ava Hernandez', orderDate: DateTime(2026, 1, 11), dueDate: DateTime(2026, 1, 16), days: 5, price: 110, status: 'Pending Down'),
    base(id: '#8009', type: 'Removal', address: 'Denver, USA', agent: 'William Clark', orderDate: DateTime(2026, 1, 10), dueDate: DateTime(2026, 1, 15), days: 5, price: 115, status: 'Scheduled Down'),
    base(id: '#8010', type: 'Removal', address: 'Boston, USA', agent: 'Isabella Lewis', technician: 'Sarah Williams', orderDate: DateTime(2026, 1, 9), dueDate: DateTime(2026, 1, 14), days: 5, price: 120, status: 'Assigned Down'),
    base(id: '#8011', type: 'Removal', address: 'Austin, USA', agent: 'Lucas Walker', orderDate: DateTime(2026, 1, 8), dueDate: DateTime(2026, 1, 13), days: 5, price: 125, status: 'Removed'),
    base(id: '#8012', type: 'Removal', address: 'Orlando, USA', agent: 'Mia Hall', orderDate: DateTime(2026, 1, 7), dueDate: DateTime(2026, 1, 12), days: 5, price: 130, status: 'Cancelled'),
  ];

  // ---- generated fill data (49 more, total 61) ----
  final cities = ['Portland, USA', 'Atlanta, USA', 'Nashville, USA', 'Detroit, USA', 'Minneapolis, USA', 'Charlotte, USA', 'Tampa, USA', 'San Diego, USA', 'Las Vegas, USA', 'Columbus, USA'];
  final agents = ['Ryan Mitchell', 'David Roberts', 'Sofia Turner', 'Grace Kim', 'Benjamin Young', 'Chloe Adams', 'Henry Scott', 'Zoe Baker', 'Jack Nelson', 'Ella Carter'];
  final statusesByType = <String, List<String>>{
    'Installation': ['Waiting on Payment', 'On Hold', 'Pending Up', 'Scheduled Up', 'Assigned Up', 'Installed', 'Cancelled'],
    'Removal': ['Pending Down', 'Scheduled Down', 'Assigned Down', 'Removed', 'Cancelled'],
  };
  const genericStatuses = ['Waiting on Payment', 'In Production', 'Ready', 'Out for Delivery', 'Delivered', 'Completed', 'Cancelled'];

  int n = 13;
  for (int i = 0; i < 49; i++) {
    final type = kOrderTypes[i % kOrderTypes.length];
    final statuses = statusesByType[type] ?? genericStatuses;
    final status = statuses[i % statuses.length];
    final hasTech = i % 4 == 0;
    orders.add(base(
      id: '#${8000 + n}',
      type: type,
      address: cities[i % cities.length],
      agent: agents[i % agents.length],
      technician: hasTech ? kInstallers[i % kInstallers.length] : null,
      orderDate: DateTime(2026, 1, 1 + (i % 27)),
      dueDate: DateTime(2026, 1, 6 + (i % 27)),
      days: 5 + (i % 3),
      price: 100 + (i * 3.5),
      status: status,
    ));
    n++;
  }

  return orders;
}

/// =========================================================================
/// SCREEN
/// =========================================================================
class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  final List<OrderRecord> _orders = _seedOrders();
  final TextEditingController _searchCtrl = TextEditingController();

  String _selectedType = kAllTab;
  String? _statusFilter;
  DateTime? _dateFilter;
  int _currentPage = 1;
  int _rowsPerPage = 10;

  List<String> get _allStatuses {
    final s = <String>{};
    for (final o in _orders) {
      s.add(o.status);
    }
    return s.toList()..sort();
  }

  List<OrderRecord> get _filtered {
    return _orders.where((o) {
      final matchesType = _selectedType == kAllTab || o.type == _selectedType;
      final matchesStatus = _statusFilter == null || o.status == _statusFilter;
      final matchesDate = _dateFilter == null ||
          (o.dueDate.year == _dateFilter!.year && o.dueDate.month == _dateFilter!.month && o.dueDate.day == _dateFilter!.day);
      final q = _searchCtrl.text.trim().toLowerCase();
      final matchesSearch = q.isEmpty ||
          o.id.toLowerCase().contains(q) ||
          o.address.toLowerCase().contains(q) ||
          o.agent.toLowerCase().contains(q);
      return matchesType && matchesStatus && matchesDate && matchesSearch;
    }).toList();
  }

  int get _totalPages {
    final len = _filtered.length;
    if (len == 0) return 1;
    return (len / _rowsPerPage).ceil();
  }

  List<OrderRecord> get _paged {
    final items = _filtered;
    final start = (_currentPage - 1) * _rowsPerPage;
    if (start >= items.length) return [];
    final end = (start + _rowsPerPage).clamp(0, items.length);
    return items.sublist(start, end);
  }

  void _selectType(String type) {
    if (_selectedType == type) return;
    setState(() {
      _selectedType = type;
      _currentPage = 1;
    });
  }

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages || page == _currentPage) return;
    setState(() => _currentPage = page);
  }

  // -----------------------------------------------------------------------
  // POPUP HANDLERS
  // -----------------------------------------------------------------------
  Future<void> _onEditDueDate(OrderRecord order) async {
    final result = await showDialog<DateTime>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => UpdateDueDateDialog(initial: order.dueDate),
    );
    if (result != null) setState(() => order.dueDate = result);
  }

  Future<void> _onEditAddress(OrderRecord order) async {
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => ChangeAddressDialog(initial: order.address),
    );
    if (result != null && result.trim().isNotEmpty) {
      setState(() => order.address = result.trim());
    }
  }

  Future<void> _onEditStatus(OrderRecord order) async {
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => const ChangeStatusDialog(),
    );
    if (result != null) setState(() => order.status = result);
  }

  Future<void> _onEditTechnician(OrderRecord order) async {
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => ChangeInstallerDialog(initial: order.technician),
    );
    if (result != null) {
      setState(() {
        order.technician = result;
        order.assignment = 'Assigned';
      });
    }
  }

  void _onViewOrder(OrderRecord order) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => OrderDetailsDialog(order: order),
    );
  }

  Future<void> _pickHeaderDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateFilter ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() {
      _dateFilter = picked;
      _currentPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final paged = _paged;
    final start = filtered.isEmpty ? 0 : (_currentPage - 1) * _rowsPerPage + 1;
    final end = ((_currentPage - 1) * _rowsPerPage + paged.length);

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
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(filtered.length),
                _buildTabBar(),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 40),
                      child: _buildTable(paged),
                    ),
                  ),
                ),
                _buildFooter(start: start, end: end, total: filtered.length),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------
  Widget _buildHeader(int total) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      child: Row(
        children: [
          const Text('Order Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
          const SizedBox(width: 12),
          const Text('Total:', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(color: AppColors.blueBadgeBg, borderRadius: BorderRadius.circular(20)),
            child: Text('$total', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.blue)),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _pickHeaderDate,
            child: Container(
              width: 130,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(color: AppColors.fieldFill, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
              child: Text(
                _dateFilter == null ? 'mm/dd/yyyy' : fmtDialogDate(_dateFilter!),
                style: TextStyle(fontSize: 12.5, color: _dateFilter == null ? AppColors.textMuted : AppColors.textPrimary),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 160,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: AppColors.fieldFill, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String?>(
                value: _statusFilter,
                isExpanded: true,
                isDense: true,
                hint: const Text('Filter by status', style: TextStyle(fontSize: 12.5, color: AppColors.textMuted)),
                icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                style: const TextStyle(fontSize: 12.5, color: AppColors.textPrimary),
                items: [
                  const DropdownMenuItem<String?>(value: null, child: Text('All statuses')),
                  ..._allStatuses.map((s) => DropdownMenuItem<String?>(value: s, child: Text(s))),
                ],
                onChanged: (v) => setState(() {
                  _statusFilter = v;
                  _currentPage = 1;
                }),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 220,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: AppColors.fieldFill, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
            child: Row(
              children: [
                const Icon(Icons.search, size: 17, color: AppColors.textMuted),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (_) => setState(() => _currentPage = 1),
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
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TAB BAR — filters the table by Type. "All" shows every row.
  // ---------------------------------------------------------------------
  Widget _buildTabBar() {
    final tabs = [kAllTab, ...kOrderTypes];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = tab == _selectedType;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => _selectType(tab),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue : AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textSecondary),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TABLE
  // ---------------------------------------------------------------------
  static const Map<String, int> _flex = {
    'sn': 3,
    'orderId': 7,
    'type': 10,
    'address': 14,
    'agent': 12,
    'technician': 12,
    'orderDate': 8,
    'dueDate': 9,
    'days': 8,
    'price': 8,
    'status': 12,
    'action': 5,
  };

  Widget _buildTable(List<OrderRecord> items) {
    return SizedBox(
      width: 1680,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _tableHeaderRow(),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: Text('No orders match this filter.', style: TextStyle(color: AppColors.textMuted, fontSize: 13))),
            )
          else
            ...List.generate(items.length, (i) {
              final sn = (_currentPage - 1) * _rowsPerPage + i + 1;
              return _tableDataRow(sn, items[i]);
            }),
        ],
      ),
    );
  }

  Widget _tableHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          _h('S.N.', _flex['sn']!),
          _h('Order Id', _flex['orderId']!),
          _h('Type', _flex['type']!),
          _h('Address', _flex['address']!),
          _h('Agent', _flex['agent']!),
          _h('Technician', _flex['technician']!),
          _h('Order Date', _flex['orderDate']!),
          _h('Due Date', _flex['dueDate']!),
          _h('Days In Field', _flex['days']!),
          _h('Price', _flex['price']!),
          _h('Status', _flex['status']!),
          _h('Action', _flex['action']!),
        ],
      ),
    );
  }

  Widget _h(String text, int flex) => Expanded(
    flex: flex,
    child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
  );

  Widget _tableDataRow(int sn, OrderRecord order) {
    final type = typeColors(order.type);
    final status = statusColors(order.status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.rowBorder))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: _flex['sn']!, child: Text('$sn', style: AppText.cell)),
          Expanded(flex: _flex['orderId']!, child: Text(order.id, style: AppText.cellLink)),
          Expanded(
            flex: _flex['type']!,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: type.bg, borderRadius: BorderRadius.circular(20)),
                child: Text(order.type, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: type.text)),
              ),
            ),
          ),
          Expanded(
            flex: _flex['address']!,
            child: Row(
              children: [
                Flexible(child: Text(order.address, overflow: TextOverflow.ellipsis, style: AppText.cell)),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _onEditAddress(order),
                  child: const Icon(Icons.edit, size: 14, color: AppColors.iconEdit),
                ),
              ],
            ),
          ),
          Expanded(
            flex: _flex['agent']!,
            child: Row(
              children: [
                const CircleAvatar(radius: 11, backgroundColor: AppColors.fieldFill, child: Icon(Icons.person, size: 13, color: AppColors.textMuted)),
                const SizedBox(width: 6),
                Flexible(child: Text(order.agent, overflow: TextOverflow.ellipsis, style: AppText.cell)),
              ],
            ),
          ),
          Expanded(
            flex: _flex['technician']!,
            child: Row(
              children: [
                Flexible(
                  child: Text(order.technician ?? 'N/A', overflow: TextOverflow.ellipsis, style: AppText.cell),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _onEditTechnician(order),
                  child: const Icon(Icons.edit_outlined, size: 14, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Expanded(flex: _flex['orderDate']!, child: Text(fmtDate(order.orderDate), style: AppText.cell)),
          Expanded(
            flex: _flex['dueDate']!,
            child: Row(
              children: [
                Text(fmtDate(order.dueDate), style: AppText.cell),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _onEditDueDate(order),
                  child: const Icon(Icons.edit_outlined, size: 14, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Expanded(flex: _flex['days']!, child: Text('${order.daysInField}', style: AppText.cell)),
          Expanded(flex: _flex['price']!, child: Text(fmtMoney(order.price), style: AppText.cell)),
          Expanded(
            flex: _flex['status']!,
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: status.bg, borderRadius: BorderRadius.circular(20)),
                    child: Text(order.status, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: status.text)),
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _onEditStatus(order),
                  child: const Icon(Icons.edit_outlined, size: 14, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Expanded(
            flex: _flex['action']!,
            child: GestureDetector(
              onTap: () => _onViewOrder(order),
              child: const Icon(Icons.remove_red_eye_outlined, size: 18, color: AppColors.iconView),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // FOOTER — pagination
  // ---------------------------------------------------------------------
  Widget _buildFooter({required int start, required int end, required int total}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
      child: Row(
        children: [
          Text('Showing $start-$end of $total', style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
          const Spacer(),
          _arrow(Icons.chevron_left, 'Previous', _currentPage > 1, () => _goToPage(_currentPage - 1)),
          const SizedBox(width: 8),
          ...List.generate(_totalPages, (i) => i + 1).map(
                (p) => Padding(padding: const EdgeInsets.symmetric(horizontal: 3), child: _pageBtn(p)),
          ),
          const SizedBox(width: 8),
          _arrow(Icons.chevron_right, 'Next', _currentPage < _totalPages, () => _goToPage(_currentPage + 1), trailing: true),
          const Spacer(),
          _rowsPerPageDropdown(),
        ],
      ),
    );
  }

  Widget _pageBtn(int page) {
    final selected = page == _currentPage;
    return GestureDetector(
      onTap: () => _goToPage(page),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryBlue : Colors.transparent,
          border: Border.all(color: selected ? AppColors.primaryBlue : AppColors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text('$page', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppColors.textSecondary)),
      ),
    );
  }

  Widget _arrow(IconData icon, String label, bool enabled, VoidCallback onTap, {bool trailing = false}) {
    final color = enabled ? AppColors.textSecondary : AppColors.textMuted;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            if (!trailing) ...[Icon(icon, size: 16, color: color), const SizedBox(width: 2)],
            Text(label, style: TextStyle(fontSize: 12.5, color: color)),
            if (trailing) ...[const SizedBox(width: 2), Icon(icon, size: 16, color: color)],
          ],
        ),
      ),
    );
  }

  Widget _rowsPerPageDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(6)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _rowsPerPage,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 16),
          style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
          items: const [10, 25, 50].map((n) => DropdownMenuItem(value: n, child: Text('$n / page'))).toList(),
          onChanged: (v) {
            if (v == null) return;
            setState(() {
              _rowsPerPage = v;
              _currentPage = 1;
            });
          },
        ),
      ),
    );
  }
}

/// =========================================================================
/// POPUP 1 — "Update Due Date"
/// =========================================================================
class UpdateDueDateDialog extends StatefulWidget {
  final DateTime? initial;
  const UpdateDueDateDialog({super.key, this.initial});

  @override
  State<UpdateDueDateDialog> createState() => _UpdateDueDateDialogState();
}

class _UpdateDueDateDialogState extends State<UpdateDueDateDialog> {
  DateTime? _date;

  @override
  void initState() {
    super.initState();
    _date = widget.initial;
  }

  Future<void> _pick() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    return _SmallDialogShell(
      title: 'Update Due Date',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Date', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          _dateBox(_date, _pick),
          const SizedBox(height: 20),
          _closeSaveRow(
            context: context,
            onSave: () => Navigator.of(context).pop(_date),
            saveEnabled: _date != null,
          ),
        ],
      ),
    );
  }
}

/// =========================================================================
/// POPUP 2 — "Change Address"
/// =========================================================================
class ChangeAddressDialog extends StatefulWidget {
  final String initial;
  const ChangeAddressDialog({super.key, required this.initial});

  @override
  State<ChangeAddressDialog> createState() => _ChangeAddressDialogState();
}

class _ChangeAddressDialogState extends State<ChangeAddressDialog> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SmallDialogShell(
      title: 'Change Address',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Address', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          TextField(
            controller: _ctrl,
            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Enter address',
              hintStyle: const TextStyle(fontSize: 13, color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.fieldFill,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 20),
          _closeSaveRow(context: context, onSave: () => Navigator.of(context).pop(_ctrl.text)),
        ],
      ),
    );
  }
}

/// =========================================================================
/// POPUP 3 — "Change Status" (7 colored action buttons)
/// =========================================================================
class ChangeStatusDialog extends StatelessWidget {
  const ChangeStatusDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppColors.radiusLg)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close, size: 20, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 4),
              ...kStatusActions.map((action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(action['result'] as String),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: action['color'] as Color,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(action['label'] as String, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/// =========================================================================
/// POPUP 4 — "Change Installer"
/// =========================================================================
class ChangeInstallerDialog extends StatefulWidget {
  final String? initial;
  const ChangeInstallerDialog({super.key, this.initial});

  @override
  State<ChangeInstallerDialog> createState() => _ChangeInstallerDialogState();
}

class _ChangeInstallerDialogState extends State<ChangeInstallerDialog> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return _SmallDialogShell(
      title: 'Change Installer',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Installer', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(color: AppColors.fieldFill, borderRadius: BorderRadius.circular(8)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selected,
                isExpanded: true,
                hint: const Text('Select', style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
                style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                items: kInstallers.map((n) => DropdownMenuItem(value: n, child: Text(n))).toList(),
                onChanged: (v) => setState(() => _selected = v),
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                  child: const Text('Cancel', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _selected == null ? null : () => Navigator.of(context).pop(_selected),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    disabledBackgroundColor: AppColors.primaryBlue.withOpacity(0.5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Save Change', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// =========================================================================
/// SHARED small-dialog shell + close/save row (used by popups 1 & 2)
/// =========================================================================
class _SmallDialogShell extends StatelessWidget {
  final String title;
  final Widget child;
  const _SmallDialogShell({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppColors.radiusLg)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, size: 20, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const Divider(height: 22, color: AppColors.border),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

Widget _dateBox(DateTime? date, VoidCallback onTap) {
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
              date == null ? 'mm/dd/yyyy' : fmtDialogDate(date),
              style: TextStyle(fontSize: 13, color: date == null ? AppColors.textMuted : AppColors.textPrimary),
            ),
          ),
          const Icon(Icons.calendar_today_outlined, size: 15, color: AppColors.textMuted),
        ],
      ),
    ),
  );
}

Widget _closeSaveRow({required BuildContext context, required VoidCallback onSave, bool saveEnabled = true}) {
  return Row(
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
          onPressed: saveEnabled ? onSave : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            disabledBackgroundColor: AppColors.primaryBlue.withOpacity(0.5),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 13),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Save Change', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
        ),
      ),
    ],
  );
}

/// =========================================================================
/// POPUP 5 — "Sign Installation Order Details" (Order Info / Checklist)
/// =========================================================================
class OrderDetailsDialog extends StatefulWidget {
  final OrderRecord order;
  const OrderDetailsDialog({super.key, required this.order});

  @override
  State<OrderDetailsDialog> createState() => _OrderDetailsDialogState();
}

class _OrderDetailsDialogState extends State<OrderDetailsDialog> {
  bool _showInfo = true;
  late Map<String, bool> _checklist;

  @override
  void initState() {
    super.initState();
    final order = widget.order;
    _checklist = {
      'Confirm address before departure': false,
      'Verify listing ID matches the order': false,
      for (final w in order.siteWarnings) 'Check site warning: $w': false,
      for (final a in order.addOnServices) 'Complete add-on: $a': false,
      'Install main panel securely': false,
      'Install rider panel': false,
      'Take photo confirmation of install': false,
      'Update order status when finished': false,
    };
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final done = _checklist.values.where((v) => v).length;

    return Dialog(
      backgroundColor: AppColors.cardBackground,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppColors.radiusLg)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900, maxHeight: 720),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---- Header ----
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 18, 12),
              child: Row(
                children: [
                  const Text('Sign Installation Order Details', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(color: AppColors.totalBadgeBgAlt, borderRadius: BorderRadius.circular(20)),
                    child: Text(order.assignment, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.totalBadgeTextAlt)),
                  ),
                  const Spacer(),
                  GestureDetector(onTap: () => Navigator.of(context).pop(), child: const Icon(Icons.close, size: 20, color: AppColors.textSecondary)),
                ],
              ),
            ),
            // ---- Tabs ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Expanded(child: _tabButton('Order Info', Icons.description_outlined, _showInfo, () => setState(() => _showInfo = true))),
                  const SizedBox(width: 10),
                  Expanded(child: _tabButton('Checklist', Icons.checklist_outlined, !_showInfo, () => setState(() => _showInfo = false))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                child: _showInfo ? _orderInfoContent(order) : _checklistContent(done),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String label, IconData icon, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryBlue : AppColors.chipBlack,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // ---- Order Info tab ----
  Widget _orderInfoContent(OrderRecord order) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 6, child: _infoLeftColumn(order)),
        const SizedBox(width: 20),
        Expanded(flex: 4, child: _infoRightColumn(order)),
      ],
    );
  }

  Widget _infoLeftColumn(OrderRecord order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.pageBackground, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kv('Order ID', order.detailOrderId, big: true),
              const SizedBox(height: 12),
              _kv('Address', order.address),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _kv('Unit/Apt. Number', order.unitNumber),
        const SizedBox(height: 12),
        _kv('Listing ID', order.listingId),
        const SizedBox(height: 12),
        _kv('Due Date', fmtDate(order.dueDate)),
        const SizedBox(height: 12),
        _kv('Occupant', order.occupant),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.lightBlueBg, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Note', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primaryBlue)),
              const SizedBox(height: 4),
              Text(order.note, style: const TextStyle(fontSize: 12.5, color: AppColors.textPrimary)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _kv('Property Type', order.propertyType),
        const SizedBox(height: 12),
        _kv('Where Should The Sign Be Placed?', order.signPlacement),
        const SizedBox(height: 12),
        _kv('Please Provide Gate Code (If Applicable)', order.gateCode),
        const SizedBox(height: 12),
        _kv('I Confirm That The Address Is Accurate', order.addressAccurate),
        const SizedBox(height: 12),
        _kv('Lockbox', order.lockbox),
        const SizedBox(height: 14),
        _bulletSection('Site Warnings', order.siteWarnings),
        const SizedBox(height: 14),
        _bulletSection('Add On Service', order.addOnServices),
      ],
    );
  }

  Widget _infoRightColumn(OrderRecord order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _signStack(),
        const SizedBox(height: 16),
        _kv('Post Type', order.postType),
        const SizedBox(height: 12),
        _kv('Install Type', order.installType),
        const SizedBox(height: 12),
        const Text('Rider', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text('Size: "${order.riderSize}"', style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
        Text('Material: "${order.riderMaterial}"', style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
        const SizedBox(height: 12),
        const Text('Main Panel', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text('Size: "${order.mainPanelSize}"', style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
        Text('Material: "${order.mainPanelMaterial}"', style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
        const SizedBox(height: 16),
        const Text('Property Image', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(color: AppColors.fieldFill, borderRadius: BorderRadius.circular(8)),
          child: const Center(child: Icon(Icons.apartment, size: 40, color: AppColors.textMuted)),
        ),
      ],
    );
  }

  Widget _signStack() {
    return Column(
      children: [
        _soldBanner(),
        const SizedBox(height: 6),
        _soldBanner(),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(color: const Color(0xFFF6E94A), borderRadius: BorderRadius.circular(4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('FOR SALE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF1B2A4A))),
              SizedBox(height: 4),
              Text('AGENT NAME', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF1B2A4A))),
              Text('555-555-5555', style: TextStyle(fontSize: 9, color: Color(0xFF1B2A4A))),
            ],
          ),
        ),
        const SizedBox(height: 6),
        _soldBanner(),
      ],
    );
  }

  Widget _soldBanner() {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(color: const Color(0xFF0B3D91), borderRadius: BorderRadius.circular(4)),
      child: const Center(
        child: Text('SOLD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1)),
      ),
    );
  }

  Widget _kv(String label, String value, {bool big = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
        const SizedBox(height: 3),
        Text(value, style: TextStyle(fontSize: big ? 15 : 13, fontWeight: big ? FontWeight.w800 : FontWeight.w500, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _bulletSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        ...items.asMap().entries.map(
              (e) => Text('${e.key + 1}. ${e.value}', style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
        ),
      ],
    );
  }

  // ---- Checklist tab (no reference screenshot was supplied for this tab,
  // so this is a reasonable install checklist built from the order's own
  // site warnings / add-on services plus standard install steps) ----
  Widget _checklistContent(int done) {
    final total = _checklist.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Installation Checklist', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            Text('$done / $total complete', style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
          ],
        ),
        const SizedBox(height: 12),
        ..._checklist.keys.map((task) {
          final checked = _checklist[task]!;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: checked,
                  activeColor: AppColors.primaryBlue,
                  onChanged: (v) => setState(() => _checklist[task] = v ?? false),
                ),
                Expanded(
                  child: Text(
                    task,
                    style: TextStyle(
                      fontSize: 13,
                      color: checked ? AppColors.textMuted : AppColors.textPrimary,
                      decoration: checked ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}