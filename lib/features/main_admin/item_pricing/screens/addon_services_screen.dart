import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../widgets/list_page_header.dart';
import '../widgets/row_actions.dart';
import '../widgets/app_dialog_shell.dart';
import '../widgets/dashed_box.dart';

class AddOnService {
  String name;
  String type;
  String visibleTo;
  String? agentOrOffice;
  double price;
  String note;

  AddOnService({
    required this.name,
    required this.type,
    required this.visibleTo,
    this.agentOrOffice,
    required this.price,
    this.note = '',
  });
}

class AddOnServicesScreen extends StatefulWidget {
  const AddOnServicesScreen({super.key});

  @override
  State<AddOnServicesScreen> createState() => _AddOnServicesScreenState();
}

class _AddOnServicesScreenState extends State<AddOnServicesScreen> {
  static const types = ['Sign Installation', 'For Sale Directionals', 'Open House Directionals', 'Media Services', 'Other Services'];
  static const visibility = ['Everyone', 'Agent', 'Team_lead'];

  final List<AddOnService> _services = [
    AddOnService(name: 'Premium Top Mount Installation', type: 'Sign Installation', visibleTo: 'Everyone', price: 120),
    AddOnService(name: 'Sliding Panel Installation', type: 'Sign Installation', visibleTo: 'Everyone', price: 95),
    AddOnService(name: 'Arrow Guide Sign', type: 'For Sale Directionals', visibleTo: 'Agent', agentOrOffice: 'goni', price: 45),
    AddOnService(name: 'Directional Board', type: 'For Sale Directionals', visibleTo: 'Everyone', price: 85),
    AddOnService(name: 'Open House Weekend Setup', type: 'Open House Directionals', visibleTo: 'Team_lead', price: 110),
    AddOnService(name: 'Reflective Open House Sign', type: 'Open House Directionals', visibleTo: 'Everyone', price: 70),
    AddOnService(name: 'Real Estate Photography', type: 'Media Services', visibleTo: 'Agent', agentOrOffice: 'raj', price: 250),
    AddOnService(name: 'Aerial Drone Photography', type: 'Media Services', visibleTo: 'Everyone', price: 320),
    AddOnService(name: 'Sign Pickup & Removal', type: 'Other Services', visibleTo: 'Everyone', price: 50),
    AddOnService(name: 'Special Custom Request', type: 'Other Services', visibleTo: 'Team_lead', price: 150),
  ];

  String _query = '';

  List<AddOnService> get _filtered =>
      _services.where((s) => s.name.toLowerCase().contains(_query.toLowerCase())).toList();

  Future<void> _openDialog({AddOnService? existing}) async {
    final result = await showDialog<AddOnService>(
      context: context,
      builder: (_) => _AddOnServiceDialog(existing: existing),
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

  void _delete(AddOnService s) => setState(() => _services.remove(s));

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
                ListPageHeader(
                  title: 'Add-On Services',
                  total: _services.length,
                  addLabel: 'Add-On Service',
                  onAdd: () => _openDialog(),
                  onSearch: (v) => setState(() => _query = v),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(width: 1080, child: _table(rows)),
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

  static const _wSn = 50.0;
  static const _wImage = 70.0;
  static const _wName = 230.0;
  static const _wType = 190.0;
  static const _wVisible = 100.0;
  static const _wAgent = 110.0;
  static const _wPrice = 80.0;
  static const _wActions = 90.0;

  Widget _table(List<AddOnService> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            SizedBox(width: _wSn, child: Text('S.N.', style: AppText.columnHeader)),
            SizedBox(width: _wImage, child: Text('Image', style: AppText.columnHeader)),
            SizedBox(width: _wName, child: Text('Name', style: AppText.columnHeader)),
            SizedBox(width: _wType, child: Text('Type', style: AppText.columnHeader)),
            SizedBox(width: _wVisible, child: Text('Visible To', style: AppText.columnHeader)),
            SizedBox(width: _wAgent, child: Text('Agents / Offices', style: AppText.columnHeader)),
            SizedBox(width: _wPrice, child: Text('Price', style: AppText.columnHeader)),
            SizedBox(width: _wActions, child: Text('Action', style: AppText.columnHeader)),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: AppColors.border),
        for (int i = 0; i < rows.length; i++) ...[
          Padding(padding: const EdgeInsets.symmetric(vertical: 11), child: _row(i + 1, rows[i])),
          const Divider(height: 1, color: AppColors.border),
        ],
      ],
    );
  }

  Widget _row(int sn, AddOnService s) {
    return Row(
      children: [
        SizedBox(width: _wSn, child: Text('$sn', style: AppText.cellMuted)),
        SizedBox(
          width: _wImage,
          child: const CircleAvatar(radius: 16, backgroundColor: Color(0xFFE5E7EB), child: Icon(Icons.person, size: 16, color: Colors.white)),
        ),
        SizedBox(width: _wName, child: Text(s.name, style: AppText.cell, overflow: TextOverflow.ellipsis)),
        SizedBox(width: _wType, child: Text(s.type, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary))),
        SizedBox(width: _wVisible, child: Text(s.visibleTo, style: AppText.cell)),
        SizedBox(
          width: _wAgent,
          child: s.agentOrOffice == null
              ? const SizedBox.shrink()
              : Pill(label: s.agentOrOffice!, bg: AppColors.blueLight, fg: AppColors.blueLink, dense: true),
        ),
        SizedBox(width: _wPrice, child: Text('\$${s.price.toStringAsFixed(0)}', style: AppText.cell)),
        SizedBox(
          width: _wActions,
          child: RowActions(onEdit: () => _openDialog(existing: s), onDelete: () => _delete(s)),
        ),
      ],
    );
  }
}

class _AddOnServiceDialog extends StatefulWidget {
  final AddOnService? existing;
  const _AddOnServiceDialog({this.existing});

  @override
  State<_AddOnServiceDialog> createState() => _AddOnServiceDialogState();
}

class _AddOnServiceDialogState extends State<_AddOnServiceDialog> {
  late final TextEditingController _name;
  late final TextEditingController _price;
  late final TextEditingController _note;
  String? _type;
  String? _visibleTo;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?.name ?? '');
    _price = TextEditingController(text: e?.price.toString() ?? '');
    _note = TextEditingController(text: e?.note ?? '');
    _type = e?.type;
    _visibleTo = e?.visibleTo;
  }

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogShell(
      title: _isEdit ? 'Edit Add-On Service' : 'Add-On Service',
      primaryLabel: _isEdit ? 'Save' : 'Add',
      onPrimaryPressed: () {
        Navigator.of(context).pop(AddOnService(
          name: _name.text.isEmpty ? (widget.existing?.name ?? 'Untitled') : _name.text,
          type: _type ?? (widget.existing?.type ?? ''),
          visibleTo: _visibleTo ?? (widget.existing?.visibleTo ?? 'Everyone'),
          agentOrOffice: widget.existing?.agentOrOffice,
          price: double.tryParse(_price.text) ?? 0,
          note: _note.text,
        ));
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabeledField(label: 'Name', controller: _name, hint: 'Type here..'),
          const SizedBox(height: 14),
          const Text('Service Image', style: AppText.fieldLabel),
          const SizedBox(height: 6),
          const ImageUploadBox(),
          const SizedBox(height: 14),
          AppLabeledDropdown(
            label: 'Select Type',
            value: _type,
            items: _AddOnServicesScreenState.types,
            onChanged: (v) => setState(() => _type = v),
          ),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Price', controller: _price, hint: 'Enter price', keyboardType: TextInputType.number),
          const SizedBox(height: 14),
          AppLabeledDropdown(
            label: 'Visible To',
            value: _visibleTo,
            hint: 'Select visibility',
            items: _AddOnServicesScreenState.visibility,
            onChanged: (v) => setState(() => _visibleTo = v),
          ),
          const SizedBox(height: 14),
          AppLabeledField(label: 'Note', controller: _note, hint: 'Type here..'),
        ],
      ),
    );
  }
}
