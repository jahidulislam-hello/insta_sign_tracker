

import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


// ----------------------------- MODEL -----------------------------

enum ApprovalStatus { pending, approved, rejected }

class Approval {
  String name;
  String email;
  String role;
  String phone;
  String joinDate;
  ApprovalStatus status;
  int totalOrders;
  int assistant;
  String office;
  String brokerage;

  Approval({
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.joinDate,
    this.status = ApprovalStatus.pending,
    this.totalOrders = 50,
    this.assistant = 1,
    this.office = 'Real estate office',
    this.brokerage = 'Brokerage office',
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}

// ----------------------------- ROLE OPTIONS / COLORS -----------------------------

const List<String> kRoleFilterOptions = [
  'All',
  'Agent',
  'Team Lead',
  'Assistant',
  'Installer',
  'Warehouse manger',
  'Sign company',
];

// Uses the shared `BadgeColor` type from app_colors.dart, built from the
// existing badge tokens (lightBlueBg/primaryBlue, photographerBg/Text,
// greenLight/green, orangeLight/orange) plus the purple "totalBadgeAlt"
// pair for Team Lead, which had no existing equivalent.
BadgeColor roleStyleFor(String role) {
  switch (role) {
    case 'Agent':
      return const BadgeColor(AppColors.lightBlueBg, AppColors.blue);
    case 'Sign company':
      return const BadgeColor(AppColors.photographerBg, AppColors.photographerText);
    case 'Assistant':
    case 'Warehouse manger':
      return const BadgeColor(AppColors.greenLight, AppColors.green);
    case 'Team Lead':
      return const BadgeColor(AppColors.totalBadgeBgAlt, AppColors.totalBadgeTextAlt);
    case 'Installer':
      return const BadgeColor(AppColors.orangeLight, AppColors.orange);
    default:
      return const BadgeColor(AppColors.fieldFill, AppColors.textSecondary);
  }
}

// ----------------------------- MAIN PAGE -----------------------------

class AllApprovalsPage extends StatefulWidget {
  const AllApprovalsPage({super.key});

  @override
  State<AllApprovalsPage> createState() => _AllApprovalsPageState();
}

class _AllApprovalsPageState extends State<AllApprovalsPage> {
  late List<Approval> _all;
  String _roleFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  int _page = 1;
  int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _all = _seedData();
  }

  List<Approval> _seedData() {
    return [
      Approval(name: "Todd's Company", email: 'todd@gmail.com', role: 'Agent', phone: '+8564564654', joinDate: '02/20/2026'),
      Approval(name: 'Unknown Agent', email: 'unknown1@gmail.com', role: 'Agent', phone: '+8564564654', joinDate: '02/20/2026'),
      Approval(name: 'Coldwell Banker', email: 'coldwell@gmail.com', role: 'Agent', phone: '+8564564654', joinDate: '02/20/2026'),
      Approval(name: 'Unknown Agent 2', email: 'unknown2@gmail.com', role: 'Agent', phone: '+8564564654', joinDate: '02/20/2026'),
      Approval(name: 'New Company', email: 'new@gmail.com', role: 'Agent', phone: '+8564564654', joinDate: '02/20/2026'),
      Approval(name: 'Agent 6', email: 'nsujon8@gmail.com', role: 'Sign company', phone: '+8564564654', joinDate: '02/20/2026'),
      Approval(name: 'Lovie Test Compar', email: 'lovie@gmail.com', role: 'Agent', phone: '+880171234567', joinDate: '02/19/2026'),
      Approval(name: 'Sarah Ahmed', email: 'sarah@gmail.com', role: 'Assistant', phone: '+880171234568', joinDate: '02/18/2026'),
      Approval(name: 'Michael Brown', email: 'michael@gmail.com', role: 'Team Lead', phone: '+880171234569', joinDate: '02/18/2026'),
      Approval(name: 'Daniel Smith', email: 'daniel@gmail.com', role: 'Installer', phone: '+880171234560', joinDate: '02/17/2026'),
      Approval(name: 'Emily Clark', email: 'emily@gmail.com', role: 'Agent', phone: '+880171234561', joinDate: '02/16/2026'),
      Approval(name: 'Warehouse Wendy', email: 'wendy@gmail.com', role: 'Warehouse manger', phone: '+880171234562', joinDate: '02/16/2026'),
      Approval(name: 'Chris Green', email: 'chris@gmail.com', role: 'Agent', phone: '+880171234563', joinDate: '02/15/2026'),
      Approval(name: 'Nina Patel', email: 'nina@gmail.com', role: 'Sign company', phone: '+880171234564', joinDate: '02/15/2026'),
      Approval(name: 'Oscar Diaz', email: 'oscar@gmail.com', role: 'Installer', phone: '+880171234565', joinDate: '02/14/2026'),
      Approval(name: 'Grace Lee', email: 'grace@gmail.com', role: 'Assistant', phone: '+880171234566', joinDate: '02/14/2026'),
      Approval(name: 'Henry Ford', email: 'henry@gmail.com', role: 'Team Lead', phone: '+880171234567', joinDate: '02/13/2026'),
      Approval(name: 'Ivy Chen', email: 'ivy@gmail.com', role: 'Agent', phone: '+880171234568', joinDate: '02/13/2026'),
      Approval(name: 'Jack Ryan', email: 'jack@gmail.com', role: 'Agent', phone: '+880171234569', joinDate: '02/12/2026'),
      Approval(name: 'Karen White', email: 'karen@gmail.com', role: 'Warehouse manger', phone: '+880171234570', joinDate: '02/12/2026'),
    ];
  }

  List<Approval> get _filtered {
    final q = _searchController.text.trim().toLowerCase();
    return _all.where((a) {
      final matchesRole = _roleFilter == 'All' || a.role == _roleFilter;
      final matchesQuery = q.isEmpty ||
          a.name.toLowerCase().contains(q) ||
          a.email.toLowerCase().contains(q);
      return matchesRole && matchesQuery && a.status == ApprovalStatus.pending;
    }).toList();
  }

  List<Approval> get _pageItems {
    final f = _filtered;
    final start = (_page - 1) * _pageSize;
    if (start >= f.length) return [];
    final end = (start + _pageSize).clamp(0, f.length);
    return f.sublist(start, end);
  }

  int get _totalPages => (_filtered.length / _pageSize).ceil().clamp(1, 999);

  // ---------- Dialog launchers ----------

  void _openView(Approval a) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => ViewApprovalDialog(approval: a),
    );
  }

  void _openApprove(Approval a) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => ApproveRejectDialog(
        name: a.name,
        isApprove: true,
        onConfirm: () {
          setState(() => a.status = ApprovalStatus.approved);
        },
      ),
    );
  }

  void _openReject(Approval a) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => ApproveRejectDialog(
        name: a.name,
        isApprove: false,
        onConfirm: () {
          setState(() => a.status = ApprovalStatus.rejected);
        },
      ),
    );
  }

  void _openRoleFilter() async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    // Position roughly under the filter control; simplified with a fixed offset.
    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        overlay.size.width - 520,
        90,
        overlay.size.width - 300,
        0,
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.border)),
      items: kRoleFilterOptions
          .map((r) => PopupMenuItem<String>(
        value: r,
        child: Text(r,
            style: TextStyle(
                fontSize: 13,
                fontWeight: r == _roleFilter ? FontWeight.w700 : FontWeight.w400,
                color: r == _roleFilter ? AppColors.blue : AppColors.textPrimary)),
      ))
          .toList(),
    );
    if (selected != null) {
      setState(() {
        _roleFilter = selected;
        _page = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredCount = _filtered.length;
    final start = filteredCount == 0 ? 0 : (_page - 1) * _pageSize + 1;
    final end = ((_page - 1) * _pageSize + _pageItems.length);

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
                  child: _pageItems.isEmpty
                      ? const Center(
                      child: Text('No approvals found',
                          style: TextStyle(color: AppColors.textSecondary)))
                      : ListView.separated(
                    itemCount: _pageItems.length,
                    separatorBuilder: (_, __) => const Divider(
                        height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final sn = (_page - 1) * _pageSize + index + 1;
                      return _buildRow(sn, _pageItems[index]);
                    },
                  ),
                ),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 10),
                _buildFooter(start, end, filteredCount),
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
          'All Approvals',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(width: 10),
        const Text('Total: ', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        Container(
          width: 26,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.headerBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text('${_all.where((a) => a.status == ApprovalStatus.pending).length}',
              style: const TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 12)),
        ),
        const Spacer(),
        Builder(builder: (btnContext) {
          return InkWell(
            onTap: _openRoleFilter,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 160,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _roleFilter == 'All' ? 'Filter by role' : _roleFilter,
                      style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textSecondary),
                ],
              ),
            ),
          );
        }),
        const SizedBox(width: 12),
        SizedBox(
          width: 220,
          height: 40,
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() => _page = 1),
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search here...',
              hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
              prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textSecondary),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
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
          SizedBox(width: 36, child: Text('S.N', style: style)),
          Expanded(flex: 3, child: Text('Name', style: style)),
          Expanded(flex: 3, child: Text('Email', style: style)),
          Expanded(flex: 2, child: Text('Role', style: style)),
          Expanded(flex: 2, child: Text('Phone', style: style)),
          Expanded(flex: 2, child: Text('Join Date', style: style)),
          SizedBox(width: 230, child: Text('Action', style: style)),
        ],
      ),
    );
  }

  Widget _buildRow(int sn, Approval a) {
    final rs = roleStyleFor(a.role);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          SizedBox(
              width: 36,
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
                  child: Text(a.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(a.email,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: AppColors.emailText)),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: rs.background,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(a.role,
                    style: TextStyle(fontSize: 12, color: rs.text, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(a.phone,
                style: const TextStyle(fontSize: 13, color: AppColors.emailText)),
          ),
          Expanded(
            flex: 2,
            child: Text(a.joinDate,
                style: const TextStyle(fontSize: 13, color: AppColors.emailText)),
          ),
          SizedBox(
            width: 230,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _openView(a),
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  color: AppColors.textSecondary,
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 32,
                  width: 84,
                  child: ElevatedButton(
                    onPressed: () => _openApprove(a),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text('Approve', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 32,
                  width: 76,
                  child: OutlinedButton(
                    onPressed: () => _openReject(a),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.blue,
                      side: const BorderSide(color: AppColors.border),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text('Reject', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(int start, int end, int total) {
    return Row(
      children: [
        Text(
          total == 0 ? 'Showing 0 of 0' : 'Showing $start-$end of $total',
          style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
        ),
        const Spacer(),
        _pageNavButton('Previous', Icons.chevron_left, _page > 1, () {
          setState(() => _page--);
        }, leading: true),
        const SizedBox(width: 8),
        for (int p = 1; p <= _totalPages; p++) ...[
          _pageNumberButton(p),
          const SizedBox(width: 6),
        ],
        _pageNavButton('Next', Icons.chevron_right, _page < _totalPages, () {
          setState(() => _page++);
        }, leading: false),
        const SizedBox(width: 16),
        Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _pageSize,
              icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textSecondary),
              style: const TextStyle(fontSize: 12.5, color: AppColors.textPrimary),
              items: const [10, 20, 50]
                  .map((n) => DropdownMenuItem(value: n, child: Text('$n / page')))
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  _pageSize = v;
                  _page = 1;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _pageNavButton(
      String label, IconData icon, bool enabled, VoidCallback onTap,
      {required bool leading}) {
    final color = enabled ? AppColors.textPrimary : AppColors.textSecondary.withOpacity(0.5);
    final children = leading
        ? [Icon(icon, size: 16, color: color), const SizedBox(width: 2), Text(label, style: TextStyle(color: color, fontSize: 12.5))]
        : [Text(label, style: TextStyle(color: color, fontSize: 12.5)), const SizedBox(width: 2), Icon(icon, size: 16, color: color)];
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Row(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }

  Widget _pageNumberButton(int page) {
    final isActive = page == _page;
    return InkWell(
      onTap: () => setState(() => _page = page),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: isActive ? null : Border.all(color: AppColors.border),
        ),
        child: Text('$page',
            style: TextStyle(
                fontSize: 12.5,
                color: isActive ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// ----------------------------- DIALOG SHELL -----------------------------

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

class ViewApprovalDialog extends StatelessWidget {
  final Approval approval;
  const ViewApprovalDialog({super.key, required this.approval});

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
                approval.initials,
                style: const TextStyle(
                    color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),
            Text(approval.name,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(approval.role,
                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            const Divider(color: AppColors.border),
            const SizedBox(height: 8),
            _iconRow(Icons.mail_outline, approval.email),
            const SizedBox(height: 10),
            _iconRow(Icons.call_outlined, approval.phone),
            const SizedBox(height: 14),
            const Divider(color: AppColors.border),
            const SizedBox(height: 8),
            _statRow('TOTAL ORDERS', '${approval.totalOrders}'),
            _statRow('ASSISTANT', '${approval.assistant}'),
            _statRow('OFFICE', approval.office),
            _statRow('BROKERAGE', approval.brokerage),
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

// ----------------------------- APPROVE / REJECT DIALOG -----------------------------

class ApproveRejectDialog extends StatefulWidget {
  final String name;
  final bool isApprove;
  final VoidCallback onConfirm;

  const ApproveRejectDialog({
    super.key,
    required this.name,
    required this.isApprove,
    required this.onConfirm,
  });

  @override
  State<ApproveRejectDialog> createState() => _ApproveRejectDialogState();
}

class _ApproveRejectDialogState extends State<ApproveRejectDialog> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    final isApprove = widget.isApprove;
    final title = isApprove ? 'Approve User Registration' : 'Reject User Registration';
    final actionColor = isApprove ? AppColors.blue : AppColors.dangerRed;
    final actionLabel = isApprove ? 'Approve' : 'Reject';
    final descriptionLead = isApprove
        ? 'You are about to approve the registration request for '
        : 'You are about to reject the registration request for ';
    final descriptionTail = isApprove
        ? '. This will grant them access to the platform with their designated role.'
        : '. This will dismiss their application to join the platform.';
    final confirmLabel = isApprove
        ? 'I confirm that I want to approve this user.'
        : 'I confirm that I want to reject this user.';

    return DialogShell(
      width: 420,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary, height: 1.5),
                children: [
                  TextSpan(text: descriptionLead),
                  TextSpan(
                    text: widget.name,
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: descriptionTail),
                ],
              ),
            ),
            const SizedBox(height: 18),
            InkWell(
              onTap: () => setState(() => _confirmed = !_confirmed),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: _confirmed,
                      onChanged: (v) => setState(() => _confirmed = v ?? false),
                      activeColor: actionColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(confirmLabel,
                          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Divider(color: AppColors.border),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('No'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _confirmed
                      ? () {
                    widget.onConfirm();
                    Navigator.pop(context);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: actionColor,
                    disabledBackgroundColor: actionColor.withOpacity(0.4),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(actionLabel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}