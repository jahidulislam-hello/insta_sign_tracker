import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// COLORS
// ---------------------------------------------------------------------------
class AppColors {
  static const bg = Color(0xFFF6F8FC);
  static const cardBorder = Color(0xFFE9ECF5);
  static const textDark = Color(0xFF1E2432);
  static const textGrey = Color(0xFF8992A3);
  static const blue = Color(0xFF3E7BFA);
  static const blueLight = Color(0xFFEAF1FF);
  static const orange = Color(0xFFF5A623);
  static const orangeLight = Color(0xFFFFF3E1);
  static const green = Color(0xFF17A567);
  static const greenLight = Color(0xFFE8F8F0);
  static const greyBadgeBg = Color(0xFFF1F2F6);
  static const greyBadgeText = Color(0xFF8992A3);
}

// ---------------------------------------------------------------------------
// MODELS
// ---------------------------------------------------------------------------
class InvoiceRow {
  final String name;
  final String? avatarUrl; // null -> placeholder icon
  final Color avatarColor;
  final String role; // Photographer / Installer
  final String invoiceNo;
  final String dateRange;
  final int appts;
  final bool edited;
  final double charge;
  final bool showDollarAction;

  InvoiceRow({
    required this.name,
    this.avatarUrl,
    this.avatarColor = const Color(0xFFDDE3F0),
    required this.role,
    required this.invoiceNo,
    required this.dateRange,
    required this.appts,
    required this.edited,
    required this.charge,
    this.showDollarAction = true,
  });
}

final List<InvoiceRow> pendingInvoices = [
  InvoiceRow(
    name: 'undefined unde...',
    role: 'Photographer',
    invoiceNo: 'BP1-V000004',
    dateRange: 'Sunday - April 17th 2022 to Sunday - April 24th 2022',
    appts: 1,
    edited: false,
    charge: 0.00,
  ),
  InvoiceRow(
    name: 'undefined unde...',
    role: 'Installer',
    invoiceNo: 'BP1-V000005',
    dateRange: 'Sunday - May 1st 2022 to Sunday - May 8th 2022',
    appts: 1,
    edited: false,
    charge: 0.00,
  ),
  InvoiceRow(
    name: 'undefined unde...',
    role: 'Photographer',
    invoiceNo: 'BP1-V000006',
    dateRange: 'Sunday - May 8th 2022 to Sunday - May 15th 2022',
    appts: 1,
    edited: false,
    charge: 27.50,
  ),
  InvoiceRow(
    name: 'Bella Photograp...',
    avatarColor: const Color(0xFFF4D9C6),
    role: 'Photographer',
    invoiceNo: 'BP1-V000010',
    dateRange: 'Sunday - September 18th 2022 to Sunday - September 25th 2022',
    appts: 3,
    edited: true,
    charge: 320.00,
  ),
  InvoiceRow(
    name: 'Andy Photogra...',
    avatarColor: const Color(0xFFCFE0F5),
    role: 'Installer',
    invoiceNo: 'BP1-V000011',
    dateRange: 'Sunday - September 18th 2022 to Sunday - September 25th 2022',
    appts: 1,
    edited: false,
    charge: 97.50,
  ),
];

final List<InvoiceRow> billingEarnings = [
  InvoiceRow(
    name: 'undefined unde...',
    role: 'Installer',
    invoiceNo: 'BP1-V000001',
    dateRange: 'Sunday - March 6th 2022 to Sunday - March 13th 2022',
    appts: 1,
    edited: false,
    charge: 0.00,
    showDollarAction: false,
  ),
  InvoiceRow(
    name: 'Craig Magrum',
    avatarColor: const Color(0xFFD8D2C4),
    role: 'Photographer',
    invoiceNo: 'BP1-V000007',
    dateRange: 'Sunday - June 12th 2022 to Sunday - June 19th 2022',
    appts: 2,
    edited: true,
    charge: 268.56,
    showDollarAction: false,
  ),
  InvoiceRow(
    name: 'Lydia Vidtograp...',
    avatarColor: const Color(0xFF2B2E33),
    role: 'Photographer',
    invoiceNo: 'BP1-V000008',
    dateRange: 'Sunday - June 26th 2022 to Sunday - July 3rd 2022',
    appts: 4,
    edited: true,
    charge: 160.00,
    showDollarAction: false,
  ),
];

// ---------------------------------------------------------------------------
// PAGE
// ---------------------------------------------------------------------------
class TechnicianPage extends StatefulWidget {
  const TechnicianPage({super.key});

  @override
  State<TechnicianPage> createState() => _TechnicianPageState();
}

class _TechnicianPageState extends State<TechnicianPage> {
  int _selectedTab = 0; // 0 = Pending Invoices, 1 = Billing & Earnings

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildStatCards(),
              const SizedBox(height: 20),
              _buildTabBar(),
              const SizedBox(height: 16),
              _buildFilterRow(),
              const SizedBox(height: 16),
              _buildTableCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Technician',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Manage technician billing and pending payments',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.orangeLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'PENDING PAYMENTS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: AppColors.orange,
                ),
              ),
              SizedBox(height: 2),
              Text(
                '\$445.00',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // STAT CARDS
  // ---------------------------------------------------------------------
  Widget _buildStatCards() {
    final cards = [
      _StatCardData(
        icon: Icons.description_outlined,
        iconColor: AppColors.orange,
        iconBg: AppColors.orangeLight,
        label: 'Pending',
        value: '5',
      ),
      _StatCardData(
        icon: Icons.receipt_long_outlined,
        iconColor: AppColors.blue,
        iconBg: AppColors.blueLight,
        label: 'Paid',
        value: '3',
      ),
      _StatCardData(
        icon: Icons.access_time_rounded,
        iconColor: AppColors.orange,
        iconBg: AppColors.orangeLight,
        label: 'Pending Amt',
        value: '\$445.00',
      ),
      _StatCardData(
        icon: Icons.check_circle_outline,
        iconColor: AppColors.green,
        iconBg: AppColors.greenLight,
        label: 'Paid Amt',
        value: '\$428.56',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 720;
        if (isNarrow) {
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: cards
                .map((c) => SizedBox(
              width: (constraints.maxWidth - 12) / 2,
              child: _StatCard(data: c),
            ))
                .toList(),
          );
        }
        return Row(
          children: [
            for (int i = 0; i < cards.length; i++) ...[
              Expanded(child: _StatCard(data: cards[i])),
              if (i != cards.length - 1) const SizedBox(width: 16),
            ],
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------
  // TAB BAR
  // ---------------------------------------------------------------------
  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _tabButton('Pending Invoices', Icons.description_outlined, 0),
          const SizedBox(width: 4),
          _tabButton('Billing & Earnings', Icons.assignment_outlined, 1),
        ],
      ),
    );
  }

  Widget _tabButton(String label, IconData icon, int index) {
    final bool active = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: active ? Colors.white : AppColors.textGrey),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // FILTER ROW
  // ---------------------------------------------------------------------
  Widget _buildFilterRow() {
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 640;
      final filters = [
        _dropdownChip('All Time'),
        _dropdownChip('All Techs'),
      ];
      final search = _searchBox();

      if (isNarrow) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(spacing: 10, runSpacing: 10, children: filters),
            const SizedBox(height: 10),
            search,
          ],
        );
      }
      return Row(
        children: [
          const Spacer(),
          ...filters.map((f) => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: f,
          )),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: search,
          ),
        ],
      );
    });
  }

  Widget _dropdownChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down_rounded,
              size: 16, color: AppColors.textGrey),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, size: 16, color: AppColors.textGrey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search name/invoice...',
                hintStyle: TextStyle(fontSize: 13, color: AppColors.textGrey),
              ),
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TABLE CARD
  // ---------------------------------------------------------------------
  Widget _buildTableCard() {
    final rows = _selectedTab == 0 ? pendingInvoices : billingEarnings;
    final dateHeader = _selectedTab == 0 ? 'DATE RANGE' : 'WEEK';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _tableHeaderRow(dateHeader),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: Column(
                  key: ValueKey(_selectedTab),
                  children: [
                    for (int i = 0; i < rows.length; i++)
                      _tableDataRow(rows[i], isLast: i == rows.length - 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeaderRow(String dateHeader) {
    TextStyle style = const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: AppColors.textGrey,
      letterSpacing: 0.3,
    );
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.cardBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          SizedBox(width: 220, child: Text('NAME', style: style)),
          SizedBox(width: 110, child: Text('ROLE', style: style)),
          SizedBox(width: 130, child: Text('INVOICE NO.', style: style)),
          Expanded(child: Text(dateHeader, style: style)),
          SizedBox(width: 70, child: Text('APPTS', style: style, textAlign: TextAlign.center)),
          SizedBox(width: 70, child: Text('EDITED', style: style, textAlign: TextAlign.center)),
          SizedBox(width: 90, child: Text('CHARGE', style: style, textAlign: TextAlign.right)),
          SizedBox(width: 90, child: Text('ACTIONS', style: style, textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _tableDataRow(InvoiceRow row, {required bool isLast}) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppColors.cardBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 220,
            child: Row(
              children: [
                _avatar(row),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    row.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 110, child: _roleBadge(row.role)),
          SizedBox(
            width: 130,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.greyBadgeBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 11, color: AppColors.textGrey),
                  const SizedBox(width: 5),
                  Text('#${row.invoiceNo}',
                      style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 13, color: AppColors.textGrey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    row.dateRange,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12.5, color: AppColors.textDark),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 70,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('${row.appts}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blue)),
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Center(child: _editedBadge(row.edited)),
          ),
          SizedBox(
            width: 90,
            child: Text(
              '\$${row.charge.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionIcon(Icons.visibility_outlined),
                if (row.showDollarAction) ...[
                  const SizedBox(width: 8),
                  _actionIcon(Icons.attach_money_rounded),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(InvoiceRow row) {
    final initials = row.name.trim().isNotEmpty
        ? row.name.trim().split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join()
        : '?';
    final isPlaceholder = row.name.toLowerCase().contains('undefined');
    return CircleAvatar(
      radius: 15,
      backgroundColor: row.avatarColor,
      child: isPlaceholder
          ? const Icon(Icons.person_outline, size: 16, color: Colors.white70)
          : Text(
        initials.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _roleBadge(String role) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        role,
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: AppColors.blue,
        ),
      ),
    );
  }

  Widget _editedBadge(bool edited) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: edited ? AppColors.greenLight : AppColors.greyBadgeBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        edited ? 'Yes' : 'No',
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: edited ? AppColors.green : AppColors.greyBadgeText,
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 14, color: AppColors.textGrey),
    );
  }
}

class _StatCardData {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  _StatCardData({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
  });
}

class _StatCard extends StatelessWidget {
  final _StatCardData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: data.iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(data.icon, size: 18, color: data.iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.label,
                  style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                ),
                const SizedBox(height: 2),
                Text(
                  data.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
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