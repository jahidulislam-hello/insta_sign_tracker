import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/confirm_delete_dialog.dart';

class SignTypesScreen extends StatefulWidget {
  const SignTypesScreen({super.key});

  @override
  State<SignTypesScreen> createState() => _SignTypesScreenState();
}

class _SignTypesScreenState extends State<SignTypesScreen> {
  final _data = AppData.instance;
  String _query = '';

  List<SignType> get _filtered {
    if (_query.trim().isEmpty) return _data.signTypes;
    final q = _query.toLowerCase();
    return _data.signTypes.where((s) => s.title.toLowerCase().contains(q)).toList();
  }

  Future<void> _openForm({SignType? existing}) async {
    final controller = TextEditingController(text: existing?.title ?? '');
    final isEdit = existing != null;

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return FormDialogShell(
            title: isEdit ? 'Edit Sign Type' : 'Add Sign Type',
            primaryLabel: isEdit ? 'Save' : 'Add',
            fields: [
              LabeledField(
                label: 'Title',
                controller: controller,
                hint: 'Type here..',
              ),
            ],
            onPrimaryPressed: () {
              if (controller.text.trim().isEmpty) return;
              Navigator.of(context).pop(controller.text.trim());
            },
          );
        });
      },
    );

    if (result == null) return;
    setState(() {
      if (isEdit) {
        existing.title = result;
      } else {
        _data.signTypes.add(SignType(id: _data.nextId(), title: result));
      }
    });
  }

  Future<void> _delete(SignType item) async {
    final confirmed = await confirmDelete(context, itemName: item.title);
    if (!confirmed) return;
    setState(() => _data.signTypes.remove(item));
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return PanelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListHeader(
            title: 'Sign Types',
            total: _data.signTypes.length,
            addLabel: 'Add Sign Type',
            onAdd: () => _openForm(),
            onSearchChanged: (v) => setState(() => _query = v),
          ),
          const TableHeaderRow(columns: [
            TableColumnSpec('S.N.', flex: 1),
            TableColumnSpec('Title', flex: 6),
            TableColumnSpec('Action', flex: 2),
          ]),
          if (items.isEmpty) const EmptyRow(),
          ...List.generate(items.length, (i) {
            final item = items[i];
            return TableDataRow(
              flexes: const [1, 6, 2],
              cells: [
                Text('${i + 1}', style: AppTextStyles.cellMuted),
                Text(item.title, style: AppTextStyles.cellText),
                RowActions(
                  onEdit: () => _openForm(existing: item),
                  onDelete: () => _delete(item),
                ),
              ],
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
