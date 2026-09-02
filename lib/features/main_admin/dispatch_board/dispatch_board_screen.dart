import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


/// -----------------------------------------------------------------------
/// MODEL
/// -----------------------------------------------------------------------
class DispatchItem {
  final String id;
  final String title;
  final String technician;
  final String address;
  final String dueDate;
  final String time;

  const DispatchItem({
    required this.id,
    required this.title,
    required this.technician,
    required this.address,
    required this.dueDate,
    required this.time,
  });
}

/// -----------------------------------------------------------------------
/// MOCK DATA (matches the screenshot's first 16 rows, extended to 26 total
/// so pagination / "Total" behave the same way as the design).
/// -----------------------------------------------------------------------
const List<DispatchItem> kDispatchItems = [
  DispatchItem(id: '#661820', title: 'Install',  technician: 'Nate Johnson',    address: '6489 South Dayton Street, Englewood, CO, 80111',   dueDate: '16/05/2026', time: '7:10 AM'),
  DispatchItem(id: '#562965', title: 'Removal',  technician: 'Michale Wilhite', address: '63 Royal Ann Drive, Greenwood Village, CO, 80111',  dueDate: '18/05/2026', time: '7:16 AM'),
  DispatchItem(id: '#568055', title: 'Removal',  technician: 'Nate Johnson',    address: '8097 East Lehigh Drive, Denver, CO, 80237',         dueDate: '20/05/2026', time: '7:23 AM'),
  DispatchItem(id: '#662435', title: 'Install',  technician: 'Michale Wilhite', address: '1473 South Uinta Court, Denver, CO, 80231',         dueDate: '15/05/2026', time: '7:34 AM'),
  DispatchItem(id: '#635605', title: 'Removal',  technician: 'Roger Gauthier',  address: '10000 East Ohio Avenue, Denver, CO, 80247',         dueDate: '22/05/2026', time: '7:40 AM'),
  DispatchItem(id: '#656150', title: 'Install',  technician: 'Nate Johnson',    address: '30 Crestmoor Drive, Denver, CO, 80220',             dueDate: '17/05/2026', time: '7:50 AM'),
  DispatchItem(id: '#652270', title: 'Removal',  technician: 'Michael Lund',    address: '8564 East 28th Avenue, Denver, CO, 80238',          dueDate: '19/05/2026', time: '8:02 AM'),
  DispatchItem(id: '#629565', title: 'Removal',  technician: 'Ken Rose',        address: '2540 Poplar Street, Denver, CO, 80207',             dueDate: '21/05/2026', time: '8:06 AM'),
  DispatchItem(id: '#662340', title: 'Service',  technician: 'Michale Wilhite', address: '2263 Grape St, Denver, CO, 80207',                  dueDate: '23/05/2026', time: '8:11 AM'),
  DispatchItem(id: '#662630', title: 'Service',  technician: 'Nate Johnson',    address: '2226 Dahlia St, Denver, CO, 80207',                 dueDate: '14/05/2026', time: '8:14 AM'),
  DispatchItem(id: '#652190', title: 'Install',  technician: 'Michale Wilhite', address: '2621 Dexter Street, Denver, CO, 80207',             dueDate: '24/05/2026', time: '8:16 AM'),
  DispatchItem(id: '#663125', title: 'Service',  technician: 'Roger Gauthier',  address: '2636 Glencoe Street, Denver, CO, 80207',            dueDate: '25/05/2026', time: '8:18 AM'),
  DispatchItem(id: '#645185', title: 'Removal',  technician: 'Ken Rose',        address: '3513 Dexter Street, Denver, CO, 80207',             dueDate: '26/05/2026', time: '8:21 AM'),
  DispatchItem(id: '#626365', title: 'Removal',  technician: 'Ken Rose',        address: '3450 North Downing Street, #4, Denver, CO, 80205',  dueDate: '13/05/2026', time: '8:30 AM'),
  DispatchItem(id: '#662900', title: 'Service',  technician: 'Michael Lund',    address: '345 Fillmore Street, 203, Denver, CO, 80206',       dueDate: '27/05/2026', time: '8:46 AM'),
  DispatchItem(id: '#662720', title: 'Service',  technician: 'Ken Rose',        address: '222 S Logan St, Denver, CO, 80209',                 dueDate: '28/05/2026', time: '8:56 AM'),
  DispatchItem(id: '#664011', title: 'Install',  technician: 'Roger Gauthier',  address: '410 Steele Street, Denver, CO, 80206',              dueDate: '29/05/2026', time: '9:02 AM'),
  DispatchItem(id: '#664120', title: 'Removal',  technician: 'Michael Lund',    address: '77 Adams Street, Denver, CO, 80206',                dueDate: '30/05/2026', time: '9:10 AM'),
  DispatchItem(id: '#664240', title: 'Service',  technician: 'Nate Johnson',    address: '901 Clermont Street, Denver, CO, 80220',            dueDate: '31/05/2026', time: '9:18 AM'),
  DispatchItem(id: '#664312', title: 'Install',  technician: 'Ken Rose',        address: '1234 Filbert Street, Denver, CO, 80220',            dueDate: '01/06/2026', time: '9:24 AM'),
  DispatchItem(id: '#664410', title: 'Removal',  technician: 'Michale Wilhite', address: '789 Krameria Street, Denver, CO, 80220',            dueDate: '02/06/2026', time: '9:31 AM'),
  DispatchItem(id: '#664520', title: 'Service',  technician: 'Roger Gauthier',  address: '456 Leyden Street, Denver, CO, 80220',              dueDate: '03/06/2026', time: '9:40 AM'),
  DispatchItem(id: '#664611', title: 'Install',  technician: 'Michael Lund',    address: '210 Elm Street, Denver, CO, 80220',                 dueDate: '04/06/2026', time: '9:47 AM'),
  DispatchItem(id: '#664715', title: 'Removal',  technician: 'Nate Johnson',    address: '333 Ash Street, Denver, CO, 80220',                 dueDate: '05/06/2026', time: '9:55 AM'),
  DispatchItem(id: '#664820', title: 'Service',  technician: 'Ken Rose',        address: '87 Birch Street, Denver, CO, 80220',                dueDate: '06/06/2026', time: '10:02 AM'),
  DispatchItem(id: '#664910', title: 'Install',  technician: 'Michale Wilhite', address: '19 Cherry Street, Denver, CO, 80220',               dueDate: '07/06/2026', time: '10:11 AM'),
];

/// -----------------------------------------------------------------------
/// SCREEN
/// -----------------------------------------------------------------------
class DispatchBoardScreen extends StatefulWidget {
  const DispatchBoardScreen({super.key});

  @override
  State<DispatchBoardScreen> createState() => _DispatchBoardScreenState();
}

class _DispatchBoardScreenState extends State<DispatchBoardScreen> {
  static const String _kAll = 'All';

  late final List<String> _technicians;
  String _selectedTechnician = _kAll;
  int _currentPage = 1;
  int _rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    // Preserve first-seen order of technicians, exactly like the tab bar
    // in the design (Nate Johnson, Michale Wilhite, Roger Gauthier, ...).
    final seen = <String>{};
    final ordered = <String>[];
    for (final item in kDispatchItems) {
      if (seen.add(item.technician)) ordered.add(item.technician);
    }
    _technicians = ordered;
  }

  List<DispatchItem> get _filteredItems {
    if (_selectedTechnician == _kAll) return kDispatchItems;
    return kDispatchItems
        .where((item) => item.technician == _selectedTechnician)
        .toList();
  }

  int get _totalPages {
    final len = _filteredItems.length;
    if (len == 0) return 1;
    return (len / _rowsPerPage).ceil();
  }

  List<DispatchItem> get _pagedItems {
    final items = _filteredItems;
    final start = (_currentPage - 1) * _rowsPerPage;
    if (start >= items.length) return [];
    final end = (start + _rowsPerPage).clamp(0, items.length);
    return items.sublist(start, end);
  }

  void _selectTechnician(String technician) {
    if (_selectedTechnician == technician) return;
    setState(() {
      _selectedTechnician = technician;
      _currentPage = 1; // reset paging whenever the filter changes
    });
  }

  void _goToPage(int page) {
    if (page < 1 || page > _totalPages || page == _currentPage) return;
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;
    final paged = _pagedItems;
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
                _buildTabBar(),
                const SizedBox(height: 4),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width - 40,
                      ),
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
  // HEADER: "Dispatch Board" + "Total: N" badge
  // ---------------------------------------------------------------------
  Widget _buildHeader(int total) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      child: Row(
        children: [
          const Text(
            'Dispatch Board',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Total:',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.blueBadgeBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$total',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TAB BAR: All + one pill per technician. Tapping filters the table.
  // ---------------------------------------------------------------------
  Widget _buildTabBar() {
    final tabs = [_kAll, ..._technicians];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = tab == _selectedTechnician;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => _selectTechnician(tab),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue : AppColors.fieldFill,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
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
  static const Map<String, int> _colFlex = {
    'sn': 3,
    'id': 8,
    'title': 8,
    'technician': 12,
    'address': 34,
    'dueDate': 11,
    'time': 9,
  };

  Widget _buildTable(List<DispatchItem> items) {
    return SizedBox(
      width: 1440,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _tableHeaderRow(),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  'No dispatches for this technician.',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                ),
              ),
            )
          else
            ...List.generate(items.length, (i) {
              final globalIndex =
                  (_currentPage - 1) * _rowsPerPage + i + 1; // running S.N.
              return _tableDataRow(globalIndex, items[i]);
            }),
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
          _headerCell('ID', _colFlex['id']!),
          _headerCell('Title', _colFlex['title']!),
          _headerCell('Technician', _colFlex['technician']!),
          _headerCell('Address', _colFlex['address']!),
          _headerCell('Due Date', _colFlex['dueDate']!),
          _headerCell('Time', _colFlex['time']!),
        ],
      ),
    );
  }

  Widget _headerCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _tableDataRow(int sn, DispatchItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.rowBorder)),
      ),
      child: Row(
        children: [
          _dataCell('$sn', _colFlex['sn']!),
          _dataCell(item.id, _colFlex['id']!, style: AppText.cellLink),
          _dataCell(item.title, _colFlex['title']!),
          _dataCell(item.technician, _colFlex['technician']!),
          _dataCell(item.address, _colFlex['address']!, style: AppText.cellLink),
          _dataCell(item.dueDate, _colFlex['dueDate']!),
          _dataCell(item.time, _colFlex['time']!),
        ],
      ),
    );
  }

  Widget _dataCell(String text, int flex, {TextStyle? style}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: style ?? AppText.cell,
      ),
    );
  }

  // ---------------------------------------------------------------------
  // FOOTER: "Showing X-Y of Z" + pagination + rows-per-page selector
  // ---------------------------------------------------------------------
  Widget _buildFooter({required int start, required int end, required int total}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Row 1: "Showing X–Y of Z"  ·····  rows-per-page ──
          Row(
            children: [
              Text(
                'Showing $start–$end of $total',
                style: const TextStyle(
                    fontSize: 12.5, color: AppColors.textSecondary),
              ),
              const Spacer(),
              _rowsPerPageDropdown(),
            ],
          ),
          const SizedBox(height: 10),
          // ── Row 2: ← Previous  [pages]  Next → ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pageArrow(
                icon: Icons.chevron_left,
                label: 'Previous',
                enabled: _currentPage > 1,
                onTap: () => _goToPage(_currentPage - 1),
              ),
              const SizedBox(width: 4),
              ..._buildPageButtons(),
              const SizedBox(width: 4),
              _pageArrow(
                icon: Icons.chevron_right,
                label: 'Next',
                enabled: _currentPage < _totalPages,
                onTap: () => _goToPage(_currentPage + 1),
                trailing: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a windowed list of page buttons with ellipsis.
  /// Always shows: first, last, current, current±1, current±2 — rest collapsed to "…".
  List<Widget> _buildPageButtons() {
    if (_totalPages <= 7) {
      // Few enough pages — show all without ellipsis
      return List.generate(_totalPages, (i) => i + 1).map((page) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: _pageNumberButton(page),
      )).toList();
    }

    final pages = <Widget>[];
    final Set<int> visible = {
      1,
      _totalPages,
      _currentPage,
      if (_currentPage - 1 >= 1) _currentPage - 1,
      if (_currentPage + 1 <= _totalPages) _currentPage + 1,
    };

    int? prev;
    for (final page in visible.toList()..sort()) {
      if (prev != null && page - prev > 1) {
        // Gap — insert ellipsis
        pages.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: SizedBox(
            width: 32,
            height: 32,
            child: Center(
              child: Text(
                '…',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
            ),
          ),
        ));
      }
      pages.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: _pageNumberButton(page),
      ));
      prev = page;
    }
    return pages;
  }

  Widget _pageNumberButton(int page) {
    final isSelected = page == _currentPage;
    return GestureDetector(
      onTap: () => _goToPage(page),
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _pageArrow({
    required IconData icon,
    required String label,
    required bool enabled,
    required VoidCallback onTap,
    bool trailing = false,
  }) {
    final color = enabled ? AppColors.textSecondary : AppColors.textMuted;
    final children = [
      if (!trailing) Icon(icon, size: 16, color: color),
      if (!trailing) const SizedBox(width: 2),
      Text(label, style: TextStyle(fontSize: 12.5, color: color)),
      if (trailing) const SizedBox(width: 2),
      if (trailing) Icon(icon, size: 16, color: color),
    ];
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(children: children),
      ),
    );
  }

  Widget _rowsPerPageDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _rowsPerPage,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 16),
          style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
          items: const [10, 25, 50]
              .map((n) => DropdownMenuItem(value: n, child: Text('$n / page')))
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _rowsPerPage = value;
              _currentPage = 1;
            });
          },
        ),
      ),
    );
  }
}