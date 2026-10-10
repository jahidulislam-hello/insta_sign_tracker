import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/app_dialog_shell.dart';
import '../widgets/dashed_box.dart';

enum PriceType { fixed, variable }

class ServiceRow {
  String name;
  IconData icon;
  PriceType priceType;
  double price;
  int durationMinutes;
  DateTime dateCreated;
  bool active;

  ServiceRow({
    required this.name,
    required this.icon,
    required this.priceType,
    required this.price,
    required this.durationMinutes,
    required this.dateCreated,
    this.active = true,
  });
}

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<ServiceRow> _services = [
    ServiceRow(name: '25 Premium Images', icon: Icons.image_outlined, priceType: PriceType.fixed, price: 300, durationMinutes: 60, dateCreated: DateTime(2023, 10, 9)),
    ServiceRow(name: '40 Premium Images', icon: Icons.image_outlined, priceType: PriceType.fixed, price: 300, durationMinutes: 60, dateCreated: DateTime(2023, 11, 22)),
    ServiceRow(name: '60 Premium Images', icon: Icons.image_outlined, priceType: PriceType.fixed, price: 350, durationMinutes: 60, dateCreated: DateTime(2023, 11, 22)),
    ServiceRow(name: 'Drone Photography', icon: Icons.close, priceType: PriceType.fixed, price: 150, durationMinutes: 5, dateCreated: DateTime(2022, 3, 8)),
    ServiceRow(name: 'Drone Video', icon: Icons.videocam_outlined, priceType: PriceType.fixed, price: 199, durationMinutes: 10, dateCreated: DateTime(2022, 3, 8)),
    ServiceRow(name: 'HDR Photography', icon: Icons.camera_alt_outlined, priceType: PriceType.variable, price: 165, durationMinutes: 30, dateCreated: DateTime(2023, 12, 19)),
    ServiceRow(name: 'HDR Photography', icon: Icons.camera_alt_outlined, priceType: PriceType.variable, price: 200, durationMinutes: 70, dateCreated: DateTime(2023, 12, 14)),
    ServiceRow(name: 'HDR Photography', icon: Icons.camera_alt_outlined, priceType: PriceType.variable, price: 100, durationMinutes: 40, dateCreated: DateTime(2023, 12, 12)),
  ];

  String _query = '';
  String _activeFilter = 'All';

  static const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  String _fmtDate(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

  List<ServiceRow> get _filtered {
    return _services.where((s) {
      final matchesQuery = s.name.toLowerCase().contains(_query.toLowerCase());
      final matchesActive = _activeFilter == 'All' || (_activeFilter == 'Active' ? s.active : !s.active);
      return matchesQuery && matchesActive;
    }).toList();
  }

  Future<void> _openDialog({ServiceRow? existing}) async {
    final result = await showDialog<ServiceRow>(
      context: context,
      builder: (_) => _CreateServiceDialog(existing: existing),
    );
    if (result == null) return;
    setState(() {
      if (existing != null) {
        _services[_services.indexOf(existing)] = result;
      } else {
        _services.add(result);
      }
    });
  }

  void _delete(ServiceRow s) => setState(() => _services.remove(s));

  @override
  Widget build(BuildContext context) {
    final rows = _filtered;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  final narrow = constraints.maxWidth < 760;
                  final left = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _openDialog(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Create Service', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 14),
                      Text('You have ${_services.length} services', style: AppText.pageSubtitle),
                    ],
                  );
                  final right = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Active State', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(6)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _activeFilter,
                                items: const [
                                  DropdownMenuItem(value: 'All', child: Text('All', style: TextStyle(fontSize: 12.5))),
                                  DropdownMenuItem(value: 'Active', child: Text('Active', style: TextStyle(fontSize: 12.5))),
                                  DropdownMenuItem(value: 'Inactive', child: Text('Inactive', style: TextStyle(fontSize: 12.5))),
                                ],
                                onChanged: (v) => setState(() => _activeFilter = v!),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 220,
                        child: TextField(
                          onChanged: (v) => setState(() => _query = v),
                          style: const TextStyle(fontSize: 13),
                          decoration: inputDecoration(hint: 'Search').copyWith(
                            fillColor: AppColors.searchFieldBg,
                            prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textMuted),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
                          ),
                        ),
                      ),
                    ],
                  );
                  if (narrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Services', style: AppText.pageTitle),
                        const SizedBox(height: 14),
                        left,
                        const SizedBox(height: 12),
                        right,
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Services', style: AppText.pageTitle),
                      const SizedBox(height: 14),
                      Row(children: [left, const Spacer(), right]),
                    ],
                  );
                }),
                const SizedBox(height: 18),
                const Divider(height: 1, color: AppColors.border),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(width: 1200, child: _table(rows)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const _wThumb = 90.0;
  static const _wIcon = 60.0;
  static const _wName = 200.0;
  static const _wPriceType = 100.0;
  static const _wPrice = 130.0;
  static const _wDuration = 90.0;
  static const _wDate = 120.0;
  static const _wActive = 80.0;
  static const _wActions = 160.0;

  Widget _table(List<ServiceRow> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: const [
            SizedBox(width: _wThumb, child: Text('Thumbnail', style: AppText.columnHeader)),
            SizedBox(width: _wIcon, child: Text('Icon', style: AppText.columnHeader)),
            SizedBox(width: _wName, child: Text('Name', style: AppText.columnHeader)),
            SizedBox(width: _wPriceType, child: Text('Price Type', style: AppText.columnHeader)),
            SizedBox(width: _wPrice, child: Text('Price', style: AppText.columnHeader)),
            SizedBox(width: _wDuration, child: Text('Duration', style: AppText.columnHeader)),
            SizedBox(width: _wDate, child: Text('Date Created', style: AppText.columnHeader)),
            SizedBox(width: _wActive, child: Text('Active', style: AppText.columnHeader)),
            SizedBox(width: _wActions, child: Text('Actions', style: AppText.columnHeader)),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: AppColors.border),
        for (final s in rows) ...[
          Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: _row(s)),
          const Divider(height: 1, color: AppColors.border),
        ],
      ],
    );
  }

  Widget _row(ServiceRow s) {
    return Row(
      children: [
        SizedBox(
          width: _wThumb,
          child: Container(
            width: 64,
            height: 40,
            decoration: BoxDecoration(color: const Color(0xFFEFF1F4), borderRadius: BorderRadius.circular(6)),
            child: const Icon(Icons.image_outlined, size: 16, color: AppColors.textMuted),
          ),
        ),
        SizedBox(width: _wIcon, child: Icon(s.icon, size: 17, color: AppColors.textSecondary)),
        SizedBox(width: _wName, child: Text(s.name, style: AppText.cellLink, overflow: TextOverflow.ellipsis)),
        SizedBox(width: _wPriceType, child: Text(s.priceType == PriceType.fixed ? 'Fixed' : 'Variable', style: AppText.cell)),
        SizedBox(
          width: _wPrice,
          child: s.priceType == PriceType.fixed
              ? Text('\$${s.price.toStringAsFixed(2)}', style: AppText.cell)
              : RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
                    children: [
                      const TextSpan(text: 'Starts from '),
                      TextSpan(text: '\$${s.price.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
        ),
        SizedBox(width: _wDuration, child: Text('${s.durationMinutes}', style: AppText.cell)),
        SizedBox(width: _wDate, child: Text(_fmtDate(s.dateCreated), style: AppText.cellLink)),
        SizedBox(
          width: _wActive,
          child: Switch(
            value: s.active,
            activeColor: Colors.white,
            activeTrackColor: AppColors.blue,
            onChanged: (v) => setState(() => s.active = v),
          ),
        ),
        SizedBox(
          width: _wActions,
          child: Row(
            children: [
              _actionIcon(Icons.edit_outlined, () => _openDialog(existing: s)),
              _actionIcon(Icons.copy_outlined, () {
                setState(() => _services.add(ServiceRow(
                      name: '${s.name} (copy)',
                      icon: s.icon,
                      priceType: s.priceType,
                      price: s.price,
                      durationMinutes: s.durationMinutes,
                      dateCreated: DateTime.now(),
                      active: s.active,
                    )));
              }),
              _actionIcon(Icons.layers_outlined, () {}),
              _actionIcon(Icons.delete_outline, () => _delete(s), color: AppColors.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionIcon(IconData icon, VoidCallback onTap, {Color color = AppColors.textSecondary}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(onTap: onTap, child: Icon(icon, size: 16, color: color)),
    );
  }
}

class _CreateServiceDialog extends StatefulWidget {
  final ServiceRow? existing;
  const _CreateServiceDialog({this.existing});

  @override
  State<_CreateServiceDialog> createState() => _CreateServiceDialogState();
}

class _CreateServiceDialogState extends State<_CreateServiceDialog> {
  late final TextEditingController _name;
  late final TextEditingController _price;
  late final TextEditingController _duration;
  String? _priceType;
  bool _active = true;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name ?? '');
    _price = TextEditingController(text: e?.price.toString() ?? '');
    _duration = TextEditingController(text: e?.durationMinutes.toString() ?? '');
    _priceType = e == null ? null : (e.priceType == PriceType.fixed ? 'Fixed' : 'Variable');
    _active = e?.active ?? true;
  }

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _duration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit Service' : 'Create Service',
      primaryLabel: _isEdit ? 'Save Service' : 'Create Service',
      secondaryLabel: 'Cancel',
      onPrimaryPressed: () {
        Navigator.of(context).pop(ServiceRow(
          name: _name.text.isEmpty ? (widget.existing?.name ?? 'Untitled Service') : _name.text,
          icon: widget.existing?.icon ?? Icons.camera_alt_outlined,
          priceType: _priceType == 'Variable' ? PriceType.variable : PriceType.fixed,
          price: double.tryParse(_price.text) ?? 0,
          durationMinutes: int.tryParse(_duration.text) ?? 0,
          dateCreated: widget.existing?.dateCreated ?? DateTime.now(),
          active: _active,
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledField(label: 'Name', controller: _name, hint: 'e.g. HDR Photography'),
          const SizedBox(height: 14),
          const Text('Thumbnail', style: AppText.fieldLabel),
          const SizedBox(height: 6),
          const ImageUploadBox(height: 110),
          const SizedBox(height: 14),
          AppLabeledDropdown(
            label: 'Price Type',
            value: _priceType,
            items: const ['Fixed', 'Variable'],
            onChanged: (v) => setState(() => _priceType = v),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: AppLabeledField(label: 'Price', controller: _price, hint: 'Enter price', keyboardType: TextInputType.number)),
              const SizedBox(width: 12),
              Expanded(child: AppLabeledField(label: 'Duration (min)', controller: _duration, hint: 'Enter duration', keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Text('Active', style: AppText.fieldLabel),
              const Spacer(),
              Switch(
                value: _active,
                activeColor: Colors.white,
                activeTrackColor: AppColors.blue,
                onChanged: (v) => setState(() => _active = v),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
