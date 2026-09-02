import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/row_actions.dart';
import '../widgets/app_dialog_shell.dart';
import '../widgets/dashed_box.dart';

class ServiceCategoryRow {
  String name;
  IconData icon;
  Color iconColor;
  DateTime dateCreated;

  ServiceCategoryRow({
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.dateCreated,
  });
}

class ServiceCategoriesScreen extends StatefulWidget {
  const ServiceCategoriesScreen({super.key});

  @override
  State<ServiceCategoriesScreen> createState() => _ServiceCategoriesScreenState();
}

class _ServiceCategoriesScreenState extends State<ServiceCategoriesScreen> {
  final List<ServiceCategoryRow> _categories = [
    ServiceCategoryRow(name: '3D', icon: Icons.view_in_ar_outlined, iconColor: const Color(0xFF3B82F6), dateCreated: DateTime(2023, 10, 9)),
    ServiceCategoryRow(name: 'Drone', icon: Icons.share_outlined, iconColor: const Color(0xFF8B5CF6), dateCreated: DateTime(2023, 11, 22)),
    ServiceCategoryRow(name: 'Editing Only', icon: Icons.tune, iconColor: const Color(0xFF10B981), dateCreated: DateTime(2023, 12, 19)),
    ServiceCategoryRow(name: 'Floor Plan', icon: Icons.map_outlined, iconColor: const Color(0xFFF59E0B), dateCreated: DateTime(2024, 1, 5)),
    ServiceCategoryRow(name: 'Other', icon: Icons.hub_outlined, iconColor: const Color(0xFF6B7280), dateCreated: DateTime(2024, 2, 12)),
    ServiceCategoryRow(name: 'Photo', icon: Icons.camera_alt_outlined, iconColor: const Color(0xFFEC4899), dateCreated: DateTime(2024, 3, 2)),
    ServiceCategoryRow(name: 'Video', icon: Icons.videocam_outlined, iconColor: const Color(0xFFE11D48), dateCreated: DateTime(2024, 4, 10)),
  ];

  String _query = '';
  bool _gridView = false;

  static const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  String _fmtDate(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

  List<ServiceCategoryRow> get _filtered =>
      _categories.where((c) => c.name.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openDialog({ServiceCategoryRow? existing}) async {
    final result = await showDialog<ServiceCategoryRow>(
      context: context,
      builder: (_) => _CreateServiceCategoryDialog(existing: existing),
    );
    if (result == null) return;
    setState(() {
      if (existing != null) {
        _categories[_categories.indexOf(existing)] = result;
      } else {
        _categories.add(result);
      }
    });
  }

  void _delete(ServiceCategoryRow c) => setState(() => _categories.remove(c));

  @override
  Widget build(BuildContext context) {
    final rows = _filtered;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(builder: (context, constraints) {
                final narrow = constraints.maxWidth < 560;
                final titleBlock = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Service Categories', style: AppText.pageTitle),
                    const SizedBox(height: 4),
                    const Text('Manage your service catalogs, upload icons/thumbnails, and organize your storefront.',
                        style: AppText.pageSubtitle),
                  ],
                );
                final addBtn = ElevatedButton.icon(
                  onPressed: () => _openDialog(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Create New', style: TextStyle(fontWeight: FontWeight.w600)),
                );
                if (narrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [titleBlock, const SizedBox(height: 12), addBtn],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Expanded(child: titleBlock), addBtn],
                );
              }),
              const SizedBox(height: 18),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 10,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${_categories.length} Categories',
                        style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 240,
                    child: TextField(
                      onChanged: (v) => setState(() => _query = v),
                      style: const TextStyle(fontSize: 13),
                      decoration: inputDecoration(hint: 'Search categories...').copyWith(
                        fillColor: AppColors.searchFieldBg,
                        prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textMuted),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        _viewToggle(icon: Icons.grid_view_rounded, selected: _gridView, onTap: () => setState(() => _gridView = true)),
                        _viewToggle(icon: Icons.view_list_rounded, selected: !_gridView, onTap: () => setState(() => _gridView = false)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: cardDecoration(),
                child: _gridView ? _gridBody(rows) : _listBody(rows),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _viewToggle({required IconData icon, required bool selected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: selected ? AppColors.blueLight : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 17, color: selected ? AppColors.blueLink : AppColors.textMuted),
      ),
    );
  }

  Widget _listBody(List<ServiceCategoryRow> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
          child: Row(
            children: const [
              SizedBox(width: 70, child: Text('Icon', style: AppText.columnHeader)),
              Expanded(child: Text('Category Name', style: AppText.columnHeader)),
              SizedBox(width: 140, child: Text('Date Created', style: AppText.columnHeader)),
              SizedBox(width: 90, child: Text('Actions', style: AppText.columnHeader)),
            ],
          ),
        ),
        for (final c in rows)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
            child: Row(
              children: [
                SizedBox(width: 70, child: _iconSquare(c)),
                Expanded(child: Text(c.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
                SizedBox(width: 140, child: Text(_fmtDate(c.dateCreated), style: AppText.cellMuted)),
                SizedBox(width: 90, child: RowActions(boxed: false, onEdit: () => _openDialog(existing: c), onDelete: () => _delete(c))),
              ],
            ),
          ),
        if (rows.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: Text('No categories found', style: AppText.cellMuted)),
          ),
      ],
    );
  }

  Widget _gridBody(List<ServiceCategoryRow> rows) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [
          for (final c in rows)
            Container(
              width: 170,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _iconSquare(c),
                      const Spacer(),
                      RowActions(boxed: false, onEdit: () => _openDialog(existing: c), onDelete: () => _delete(c)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(c.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(_fmtDate(c.dateCreated), style: AppText.cellMuted),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _iconSquare(ServiceCategoryRow c) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: c.iconColor, borderRadius: BorderRadius.circular(8)),
      child: Icon(c.icon, size: 18, color: Colors.white),
    );
  }
}

class _CreateServiceCategoryDialog extends StatefulWidget {
  final ServiceCategoryRow? existing;
  const _CreateServiceCategoryDialog({this.existing});

  @override
  State<_CreateServiceCategoryDialog> createState() => _CreateServiceCategoryDialogState();
}

class _CreateServiceCategoryDialogState extends State<_CreateServiceCategoryDialog> {
  late final TextEditingController _name;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.existing?.name ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit Service Category' : 'Create Service Category',
      primaryLabel: _isEdit ? 'Save Category' : 'Create Category',
      secondaryLabel: 'Cancel',
      onPrimaryPressed: () {
        Navigator.of(context).pop(ServiceCategoryRow(
          name: _name.text.isEmpty ? (widget.existing?.name ?? 'Category') : _name.text,
          icon: widget.existing?.icon ?? Icons.category_outlined,
          iconColor: widget.existing?.iconColor ?? AppColors.blue,
          dateCreated: widget.existing?.dateCreated ?? DateTime.now(),
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledField(label: 'Category Name', controller: _name, hint: 'e.g. Drone, Floor Plan, 3D'),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Category Icon Image', style: AppText.fieldLabel),
              const Spacer(),
              const Text('Max 5MB (PNG, JPG, WEBP)', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 8),
          const ImageUploadBox(
            title: 'Upload category icon image',
            subtitle: 'Drag and drop your file here, or click to browse',
            height: 170,
          ),
        ],
      ),
    );
  }
}
