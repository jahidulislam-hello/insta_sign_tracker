import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../data/sample_technicians.dart';
import '../dialogs/add_technician_dialog.dart';
import '../dialogs/edit_technician_dialog.dart';
import '../dialogs/technician_detail_dialog.dart';
import '../models/technician.dart';
import '../widgets/role_badge.dart';

class TechniciansListScreen extends StatefulWidget {
  const TechniciansListScreen({super.key});

  @override
  State<TechniciansListScreen> createState() => _TechniciansListScreenState();
}

class _TechniciansListScreenState extends State<TechniciansListScreen> {
  final List<Technician> _all = buildSampleTechnicians();
  String _query = '';
  int _page = 1;
  static const int _pageSize = 10;

  List<Technician> get _filtered {
    if (_query.trim().isEmpty) return _all;
    final q = _query.toLowerCase();
    return _all.where((t) =>
        t.name.toLowerCase().contains(q) ||
        t.email.toLowerCase().contains(q) ||
        t.address.toLowerCase().contains(q)).toList();
  }

  List<Technician> get _pageItems {
    final f = _filtered;
    final start = (_page - 1) * _pageSize;
    if (start >= f.length) return [];
    final end = (start + _pageSize).clamp(0, f.length);
    return f.sublist(start, end);
  }

  int get _pageCount => (_filtered.length / _pageSize).ceil().clamp(1, 999);

  Future<void> _openAddDialog() async {
    final result = await showDialog<Technician>(
      context: context,
      builder: (_) => const AddTechnicianDialog(),
    );
    if (result != null) {
      setState(() {
        _all.insert(0, result);
        _page = 1;
      });
    }
  }

  Future<void> _openEditDialog(Technician t) async {
    await showDialog<Technician>(
      context: context,
      builder: (_) => EditTechnicianDialog(technician: t),
    );
    setState(() {}); // reflect any in-place edits
  }

  Future<void> _openDetailDialog(Technician t) async {
    await showDialog(
      context: context,
      builder: (_) => TechnicianDetailDialog(technician: t),
    );
    setState(() {});
  }

  void _deleteTechnician(Technician t) {
    setState(() => _all.remove(t));
  }

  @override
  Widget build(BuildContext context) {
    final items = _pageItems;
    final total = _filtered.length;
    final startIdx = total == 0 ? 0 : (_page - 1) * _pageSize + 1;
    final endIdx = ((_page - 1) * _pageSize + items.length).clamp(0, total);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _buildTableHeader(),
                      Expanded(
                        child: items.isEmpty
                            ? const Center(
                                child: Text('No technicians found', style: TextStyle(color: AppColors.textMuted)),
                              )
                            : ListView.separated(
                                itemCount: items.length,
                                separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border),
                                itemBuilder: (context, index) {
                                  final sn = (_page - 1) * _pageSize + index + 1;
                                  return _TechnicianRow(
                                    sn: sn,
                                    technician: items[index],
                                    onView: () => _openDetailDialog(items[index]),
                                    onEdit: () => _openEditDialog(items[index]),
                                    onDelete: () => _deleteTechnician(items[index]),
                                  );
                                },
                              ),
                      ),
                      _buildFooter(startIdx, endIdx, total),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 720;
      final title = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Field Technicians', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(width: 12),
          Text('Total:', style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.installerBg, borderRadius: BorderRadius.circular(8)),
            child: Text('${_all.length}', style: const TextStyle(color: AppColors.installerText, fontWeight: FontWeight.w700, fontSize: 13)),
          ),
        ],
      );

      final searchAndAdd = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 260,
            child: TextField(
              onChanged: (v) => setState(() {
                _query = v;
                _page = 1;
              }),
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search here...',
                hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.textMuted, size: 20),
                filled: true,
                fillColor: AppColors.inputFill,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: _openAddDialog,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Technician'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      );

      if (isNarrow) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title, const SizedBox(height: 14), searchAndAdd],
        );
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [title, searchAndAdd],
      );
    });
  }

  Widget _buildTableHeader() {
    const style = TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textSecondary);
    return Container(
      decoration:  BoxDecoration(
        color: AppColors.tableHeaderBg,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: const Row(
        children: [
          SizedBox(width: 40, child: Text('S.N.', style: style)),
          Expanded(flex: 3, child: Text('Name', style: style)),
          Expanded(flex: 3, child: Text('Email', style: style)),
          Expanded(flex: 2, child: Text('Phone', style: style)),
          Expanded(flex: 3, child: Text('Address', style: style)),
          Expanded(flex: 2, child: Text('Role', style: style)),
          SizedBox(width: 100, child: Text('Action', style: style)),
        ],
      ),
    );
  }

  Widget _buildFooter(int start, int end, int total) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Text('Showing $start-$end of $total', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const Spacer(),
          IconButton(
            onPressed: _page > 1 ? () => setState(() => _page--) : null,
            icon: const Icon(Icons.chevron_left, size: 18),
          ),
          for (int i = 1; i <= _pageCount; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: InkWell(
                onTap: () => setState(() => _page = i),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _page == i ? AppColors.inputFill : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: _page == i ? Border.all(color: AppColors.border) : null,
                  ),
                  child: Text('$i', style: TextStyle(fontWeight: _page == i ? FontWeight.w700 : FontWeight.w400, fontSize: 13)),
                ),
              ),
            ),
          IconButton(
            onPressed: _page < _pageCount ? () => setState(() => _page++) : null,
            icon: const Icon(Icons.chevron_right, size: 18),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('10 / page', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechnicianRow extends StatelessWidget {
  final int sn;
  final Technician technician;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TechnicianRow({
    required this.sn,
    required this.technician,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 13.5, color: AppColors.textPrimary);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 40, child: Text('$sn', style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary))),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.inputFill,
                  child: Icon(Icons.person, size: 16, color: AppColors.textMuted),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(technician.name, style: textStyle.copyWith(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Expanded(flex: 3, child: Text(technician.email, style: textStyle, overflow: TextOverflow.ellipsis)),
          Expanded(flex: 2, child: Text(technician.phone, style: textStyle, overflow: TextOverflow.ellipsis)),
          Expanded(flex: 3, child: Text(technician.address, style: textStyle, overflow: TextOverflow.ellipsis)),
          Expanded(flex: 2, child: RoleBadge(role: technician.role)),
          SizedBox(
            width: 100,
            child: Row(
              children: [
                InkWell(onTap: onView, child: const Icon(Icons.visibility_outlined, size: 19, color: AppColors.iconView)),
                const SizedBox(width: 10),
                InkWell(onTap: onEdit, child: const Icon(Icons.edit_outlined, size: 18, color: AppColors.iconEdit)),
                const SizedBox(width: 10),
                InkWell(onTap: onDelete, child: const Icon(Icons.delete_outline, size: 19, color: AppColors.iconDelete)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
