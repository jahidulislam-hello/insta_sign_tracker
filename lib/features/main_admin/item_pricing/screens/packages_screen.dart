import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/app_dialog_shell.dart';
import '../widgets/dashed_box.dart';

class PackageItem {
  String title;
  double price;
  String description;
  String visibleTo;
  List<String> features;

  PackageItem({
    required this.title,
    required this.price,
    this.description = '',
    this.visibleTo = '',
    List<String>? features,
  }) : features = features ?? [];
}

class PackageGroup {
  final String columnTitle; // e.g. "Media Services"
  final List<PackageItem> items;
  PackageGroup({required this.columnTitle, required this.items});
}

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> with SingleTickerProviderStateMixin {
  static const tabs = ['Media', 'Open House', 'For Sale Directionals'];
  static const featureOptions = ['Real Estate Photography', 'Aerial Drone Photography', 'HDR Photography', '3D Tour', 'Floor Plan'];
  static const visibility = ['Everyone', 'Agent', 'Team_lead'];

  late TabController _tabController;

  // tabIndex -> list of column groups
  late final Map<int, List<PackageGroup>> _data;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _data = {
      0: [
        PackageGroup(columnTitle: 'Media Services', items: [
          PackageItem(title: 'Package-01', price: 100),
          PackageItem(title: 'Package-02', price: 90),
        ]),
        PackageGroup(columnTitle: 'Videography', items: [
          PackageItem(title: 'Package-01', price: 100),
          PackageItem(title: 'Package-02', price: 90),
        ]),
        PackageGroup(columnTitle: 'Photography', items: [
          PackageItem(title: 'Package-01', price: 100),
          PackageItem(title: 'Package-02', price: 90),
        ]),
      ],
      1: [
        PackageGroup(columnTitle: 'Weekend Setup', items: [PackageItem(title: 'Package-01', price: 110)]),
        PackageGroup(columnTitle: 'Reflective Signs', items: [PackageItem(title: 'Package-01', price: 70)]),
        PackageGroup(columnTitle: 'Full Service', items: [PackageItem(title: 'Package-01', price: 180)]),
      ],
      2: [
        PackageGroup(columnTitle: 'Arrow Guides', items: [PackageItem(title: 'Package-01', price: 45)]),
        PackageGroup(columnTitle: 'Directional Boards', items: [PackageItem(title: 'Package-01', price: 85)]),
        PackageGroup(columnTitle: 'Bundle', items: [PackageItem(title: 'Package-01', price: 130)]),
      ],
    };
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _openDialog({required PackageGroup group, PackageItem? existing}) async {
    final result = await showDialog<PackageItem>(
      context: context,
      builder: (_) => _CreatePackageDialog(columnTitle: group.columnTitle, existing: existing),
    );
    if (result == null) return;
    setState(() {
      if (existing != null) {
        group.items[group.items.indexOf(existing)] = result;
      } else {
        group.items.add(result);
      }
    });
  }

  void _delete(PackageGroup group, PackageItem item) => setState(() => group.items.remove(item));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: AppColors.cardBackground,
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Packages', style: AppText.pageTitle),
                  const SizedBox(height: 16),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: AppColors.textPrimary,
                    unselectedLabelColor: AppColors.textSecondary,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                    indicatorColor: AppColors.blue,
                    indicatorWeight: 2.5,
                    tabAlignment: TabAlignment.start,
                    tabs: [for (final t in tabs) Tab(text: t)],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  for (int i = 0; i < tabs.length; i++) _tabBody(_data[i]!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBody(List<PackageGroup> groups) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final columns = [for (final g in groups) _packageColumn(g)];
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < columns.length; i++) ...[
                Expanded(child: columns[i]),
                if (i != columns.length - 1) const SizedBox(width: 20),
              ],
            ],
          );
        }
        return Column(
          children: [
            for (final c in columns) ...[c, const SizedBox(height: 20)],
          ],
        );
      }),
    );
  }

  Widget _packageColumn(PackageGroup group) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(group.columnTitle, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
              ElevatedButton.icon(
                onPressed: () => _openDialog(group: group),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                icon: const Icon(Icons.add, size: 15),
                label: const Text('Add Package', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < group.items.length; i++)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: i.isEven ? const Color(0xFFF7F9FC) : Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(group.items[i].title, style: AppText.cellLink)),
                  Text('\$${group.items[i].price.toStringAsFixed(2)}', style: AppText.cell),
                  const SizedBox(width: 10),
                  InkWell(onTap: () {}, child: const Icon(Icons.visibility_outlined, size: 16, color: AppColors.textSecondary)),
                  const SizedBox(width: 8),
                  InkWell(onTap: () => _openDialog(group: group, existing: group.items[i]), child: const Icon(Icons.edit_outlined, size: 16, color: AppColors.textSecondary)),
                  const SizedBox(width: 8),
                  InkWell(onTap: () => _delete(group, group.items[i]), child: const Icon(Icons.delete_outline, size: 16, color: AppColors.red)),
                ],
              ),
            ),
          if (group.items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('No packages yet', style: AppText.cellMuted),
            ),
        ],
      ),
    );
  }
}

class _CreatePackageDialog extends StatefulWidget {
  final String columnTitle;
  final PackageItem? existing;
  const _CreatePackageDialog({required this.columnTitle, this.existing});

  @override
  State<_CreatePackageDialog> createState() => _CreatePackageDialogState();
}

class _CreatePackageDialogState extends State<_CreatePackageDialog> {
  late final TextEditingController _title;
  late final TextEditingController _price;
  late final TextEditingController _description;
  String? _visibleTo;
  late List<String> _features;
  String? _pendingFeature;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _title = TextEditingController(text: e?.title ?? '');
    _price = TextEditingController(text: e?.price.toString() ?? '');
    _description = TextEditingController(text: e?.description ?? '');
    _visibleTo = e?.visibleTo.isNotEmpty == true ? e!.visibleTo : null;
    _features = List.of(e?.features ?? []);
  }

  @override
  void dispose() {
    _title.dispose();
    _price.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit ${widget.columnTitle} Package' : 'Create ${widget.columnTitle} Package',
      primaryLabel: _isEdit ? 'Save Package' : 'Create Package',
      secondaryLabel: 'Cancel',
      onPrimaryPressed: () {
        Navigator.of(context).pop(PackageItem(
          title: _title.text.isEmpty ? (widget.existing?.title ?? 'Package') : _title.text,
          price: double.tryParse(_price.text) ?? 0,
          description: _description.text,
          visibleTo: _visibleTo ?? '',
          features: _features,
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledField(label: 'Title', controller: _title, hint: 'Enter title'),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Price', controller: _price, hint: 'Enter price', keyboardType: TextInputType.number),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Description', controller: _description, hint: 'Enter short description', maxLines: 3),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 14),
          const Text('Package Image', style: AppText.fieldLabel),
          const SizedBox(height: 6),
          const ImageUploadBox(height: 120),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 14),
          AppLabeledDropdown(
            label: 'Visible To',
            value: _visibleTo,
            hint: 'Select visibility',
            items: const ['Everyone', 'Agent', 'Team_lead'],
            onChanged: (v) => setState(() => _visibleTo = v),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Text('Features', style: AppText.fieldLabel),
              const Spacer(),
              Text('${_features.length} added', style: AppText.cellMuted),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppLabeledDropdown(
                  label: '',
                  value: _pendingFeature,
                  hint: 'Select a service',
                  items: const ['Real Estate Photography', 'Aerial Drone Photography', 'HDR Photography', '3D Tour', 'Floor Plan'],
                  onChanged: (v) => setState(() => _pendingFeature = v),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  if (_pendingFeature != null && !_features.contains(_pendingFeature)) {
                    setState(() {
                      _features.add(_pendingFeature!);
                      _pendingFeature = null;
                    });
                  }
                },
                child: Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.add, size: 18, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          if (_features.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final f in _features)
                  Chip(
                    label: Text(f, style: const TextStyle(fontSize: 11.5)),
                    backgroundColor: AppColors.blueLight,
                    labelStyle: const TextStyle(color: AppColors.blueLink),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    onDeleted: () => setState(() => _features.remove(f)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
