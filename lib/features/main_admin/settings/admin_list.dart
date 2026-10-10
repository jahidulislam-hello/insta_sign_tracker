import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';



// ---------------------------------------------------------------------------
// MODEL
// ---------------------------------------------------------------------------
class AdminEntry {
  final int sn;
  final String name;
  final String email;
  final bool active;
  AdminEntry({
    required this.sn,
    required this.name,
    required this.email,
    required this.active,
  });
}

final List<AdminEntry> _sampleAdmins = [
  AdminEntry(sn: 1, name: 'Michael Carter', email: 'michael.carter@example.com', active: true),
  AdminEntry(sn: 2, name: 'Sarah Ahmed', email: 'sarah.ahmed@example.com', active: false),
  AdminEntry(sn: 3, name: 'Daniel Wilson', email: 'daniel.wilson@example.com', active: true),
  AdminEntry(sn: 4, name: 'Emma Brown', email: 'emma.brown@example.com', active: true),
  AdminEntry(sn: 5, name: 'Liam Johnson', email: 'liam.johnson@example.com', active: false),
  AdminEntry(sn: 6, name: 'Olivia Martinez', email: 'olivia.martinez@example.com', active: true),
  AdminEntry(sn: 7, name: 'Noah Taylor', email: 'noah.taylor@example.com', active: true),
  AdminEntry(sn: 8, name: 'Sophia Anderson', email: 'sophia.anderson@example.com', active: true),
  AdminEntry(sn: 9, name: 'James Walker', email: 'james.walker@example.com', active: true),
  AdminEntry(sn: 10, name: 'Isabella Hall', email: 'isabella.hall@example.com', active: true),
  AdminEntry(sn: 11, name: 'Michael Carter', email: 'michael.carter@example.com', active: true),
];

// ---------------------------------------------------------------------------
// ADMIN LIST PAGE
// ---------------------------------------------------------------------------
class AdminListPage extends StatefulWidget {
  const AdminListPage({super.key});

  @override
  State<AdminListPage> createState() => _AdminListPageState();
}

class _AdminListPageState extends State<AdminListPage> {
  int currentPage = 1;
  String pageSize = '10 / page';

  Future<void> _openAddAdminDialog() async {
    await showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (context) => const AddAdminDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TopBar(onAddAdmin: _openAddAdminDialog),
                const Divider(height: 1, color: AppColors.rowBorder),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _TableHeaderRow(),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _sampleAdmins.length,
                                itemBuilder: (context, index) {
                                  return _TableRow(admin: _sampleAdmins[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const Divider(height: 1, color: AppColors.rowBorder),
                _BottomBar(
                  currentPage: currentPage,
                  pageSize: pageSize,
                  onPageChanged: (p) => setState(() => currentPage = p),
                  onPageSizeChanged: (s) => setState(() => pageSize = s),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TOP BAR
// ---------------------------------------------------------------------------
class _TopBar extends StatelessWidget {
  final VoidCallback onAddAdmin;
  const _TopBar({required this.onAddAdmin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: LayoutBuilder(builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 760;
        final titleRow = Row(
          children: [
            const Text(
              'Admin List',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.heading,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Total:',
              style: TextStyle(fontSize: 12.5, color: AppColors.subtitle),
            ),
            const SizedBox(width: 6),
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.totalBadgeBg,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '4',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.totalBadgeText,
                ),
              ),
            ),
          ],
        );

        final controlsRow = Row(
          mainAxisSize: isNarrow ? MainAxisSize.max : MainAxisSize.min,
          children: [
            _FilterDropdown(),
            const SizedBox(width: 12),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: _SearchField(),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: onAddAdmin,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Admin'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleRow,
              const SizedBox(height: 12),
              controlsRow,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            titleRow,
            controlsRow,
          ],
        );
      }),
    );
  }
}

class _FilterDropdown extends StatefulWidget {
  @override
  State<_FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<_FilterDropdown> {
  String value = 'Filter by status';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.placeholder),
          style: const TextStyle(fontSize: 13, color: AppColors.label),
          items: const [
            DropdownMenuItem(value: 'Filter by status', child: Text('Filter by status')),
            DropdownMenuItem(value: 'Active', child: Text('Active')),
            DropdownMenuItem(value: 'Blocked', child: Text('Blocked')),
          ],
          onChanged: (v) => setState(() => value = v!),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: const [
          Icon(Icons.search, size: 18, color: AppColors.placeholder),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search here...',
                hintStyle: TextStyle(color: AppColors.placeholder, fontSize: 13),
              ),
              style: TextStyle(fontSize: 13, color: AppColors.heading),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TABLE
// ---------------------------------------------------------------------------
const double _colSN = 60;
const double _colName = 220;
const double _colImage = 130;
const double _colEmail = 260;
const double _colStatus = 160;
const double _colAction = 130;

class _TableHeaderRow extends StatelessWidget {
  const _TableHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.headerBg,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: const Row(
        children: [
          SizedBox(width: _colSN, child: Text('S.N.', style: _headerStyle)),
          SizedBox(width: _colName, child: Text('Name', style: _headerStyle)),
          SizedBox(width: _colImage, child: Text('Image', style: _headerStyle)),
          SizedBox(width: _colEmail, child: Text('Email', style: _headerStyle)),
          SizedBox(width: _colStatus, child: Text('Status', style: _headerStyle)),
          SizedBox(width: _colAction, child: Text('Action', style: _headerStyle)),
        ],
      ),
    );
  }
}

const _headerStyle = TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w600,
  color: AppColors.subtitle,
);

class _TableRow extends StatelessWidget {
  final AdminEntry admin;
  const _TableRow({required this.admin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.rowBorder)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: _colSN,
            child: Text('${admin.sn}', style: const TextStyle(fontSize: 13, color: AppColors.label)),
          ),
          SizedBox(
            width: _colName,
            child: Text(
              admin.name,
              style: const TextStyle(fontSize: 13, color: AppColors.nameLink, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: _colImage,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.inputBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.person, size: 18, color: AppColors.placeholder),
            ),
          ),
          SizedBox(
            width: _colEmail,
            child: Text(
              admin.email,
              style: const TextStyle(fontSize: 13, color: AppColors.emailText),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: _colStatus,
            child: _StatusPill(active: admin.active),
          ),
          SizedBox(
            width: _colAction,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.activeGreenBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.edit_outlined, size: 15, color: AppColors.editGreen),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.blockedRedBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.delete_outline, size: 15, color: AppColors.deleteRed),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final bool active;
  const _StatusPill({required this.active});

  @override
  Widget build(BuildContext context) {
    final bg = active ? AppColors.activeGreenBg : AppColors.blockedRedBg;
    final fg = active ? AppColors.activeGreenText : AppColors.blockedRedText;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            active ? Icons.check_circle : Icons.block,
            size: 12,
            color: fg,
          ),
          const SizedBox(width: 5),
          Text(
            active ? 'Active' : 'Blocked',
            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: fg),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BOTTOM BAR / PAGINATION
// ---------------------------------------------------------------------------
class _BottomBar extends StatelessWidget {
  final int currentPage;
  final String pageSize;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<String> onPageSizeChanged;

  const _BottomBar({
    required this.currentPage,
    required this.pageSize,
    required this.onPageChanged,
    required this.onPageSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: LayoutBuilder(builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 640;
        final showingText = const Text(
          'Showing 1-10 of 14',
          style: TextStyle(fontSize: 12.5, color: AppColors.subtitle),
        );
        final pager = _Pager(currentPage: currentPage, onPageChanged: onPageChanged);
        final sizeDropdown = _PageSizeDropdown(value: pageSize, onChanged: onPageSizeChanged);

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showingText,
              const SizedBox(height: 12),
              pager,
              const SizedBox(height: 12),
              sizeDropdown,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showingText,
            pager,
            sizeDropdown,
          ],
        );
      }),
    );
  }
}

class _Pager extends StatelessWidget {
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  const _Pager({required this.currentPage, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    Widget pageBtn(int page) {
      final isActive = page == currentPage;
      return GestureDetector(
        onTap: () => onPageChanged(page),
        child: Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.inputBorder),
          ),
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : AppColors.label,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton.icon(
          onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          icon: const Icon(Icons.chevron_left, size: 16),
          label: const Text('Previous'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.subtitle,
            textStyle: const TextStyle(fontSize: 12.5),
          ),
        ),
        pageBtn(1),
        pageBtn(2),
        pageBtn(3),
        TextButton.icon(
          onPressed: currentPage < 3 ? () => onPageChanged(currentPage + 1) : null,
          icon: const Icon(Icons.chevron_right, size: 16),
          label: const Text('Next'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.label,
            textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _PageSizeDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _PageSizeDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.placeholder),
          style: const TextStyle(fontSize: 12.5, color: AppColors.label),
          items: const [
            DropdownMenuItem(value: '10 / page', child: Text('10 / page')),
            DropdownMenuItem(value: '20 / page', child: Text('20 / page')),
            DropdownMenuItem(value: '50 / page', child: Text('50 / page')),
          ],
          onChanged: (v) => onChanged(v!),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ADD ADMIN DIALOG
// ---------------------------------------------------------------------------
class AddAdminDialog extends StatefulWidget {
  const AddAdminDialog({super.key});

  @override
  State<AddAdminDialog> createState() => _AddAdminDialogState();
}

class _AddAdminDialogState extends State<AddAdminDialog> {
  String userType = 'Admin';

  final Map<String, bool> access = {
    'Financial': false,
    'User Management': false,
    'Order Management': false,
    'Inventory Management': false,
  };

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380, maxHeight: 560),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Admin',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.heading,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 18, color: AppColors.subtitle),
                    ),
                  ],
                ),
              ),
              // Scrollable body
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DialogField(label: 'Name', controller: nameController),
                      const SizedBox(height: 14),
                      _DialogField(label: 'Email', controller: emailController),
                      const SizedBox(height: 14),
                      _DialogField(
                        label: 'Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'User type',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.label,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.inputBorder),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: userType,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down,
                                size: 18, color: AppColors.placeholder),
                            style: const TextStyle(fontSize: 13, color: AppColors.heading),
                            items: const [
                              DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                              DropdownMenuItem(value: 'Manager', child: Text('Manager')),
                              DropdownMenuItem(value: 'Editor', child: Text('Editor')),
                            ],
                            onChanged: (v) => setState(() => userType = v!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'User Access',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.label,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Scrollable toggle list (bounded height, independently scrollable)
                      SizedBox(
                        height: 160,
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: ListView(
                            padding: const EdgeInsets.only(right: 8),
                            children: access.keys.map((key) {
                              return _AccessToggleRow(
                                label: key,
                                value: access[key]!,
                                onChanged: (v) => setState(() => access[key] = v),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              // Footer buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.link,
                          side: const BorderSide(color: AppColors.inputBorder),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Collect form data and submit.
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  const _DialogField({
    required this.label,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.label,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'Type here...',
              hintStyle: TextStyle(color: AppColors.placeholder, fontSize: 13),
            ),
            style: const TextStyle(fontSize: 13, color: AppColors.heading),
          ),
        ),
      ],
    );
  }
}

class _AccessToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _AccessToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.heading),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: AppColors.primaryBlue,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFD7DAE3),
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}