import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models/assistant.dart';
import '../widgets/common.dart';
import '../widgets/add_office_dialog.dart';
import '../widgets/create_order_dialog.dart';
import '../widgets/profile_dialog.dart';
import '../widgets/edit_office_dialog.dart';
import '../widgets/delete_confirm_dialog.dart';

class AssistantsScreen extends StatefulWidget {
  const AssistantsScreen({super.key});

  @override
  State<AssistantsScreen> createState() => _AssistantsScreenState();
}

class _AssistantsScreenState extends State<AssistantsScreen> {
  final List<Assistant> _assistants = List.of(Assistant.sample);

  void _openAddOffice() {
    showDialog(context: context, builder: (_) => const AddOfficeDialog());
  }

  void _openCreateOrder(Assistant a) {
    showDialog(context: context, builder: (_) => CreateOrderDialog(assistant: a));
  }

  void _openProfile(Assistant a) {
    showDialog(context: context, builder: (_) => ProfileDialog(assistant: a));
  }

  void _openEdit(Assistant a) {
    showDialog(context: context, builder: (_) => EditOfficeDialog(assistant: a));
  }

  void _openDelete(Assistant a) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteConfirmDialog(),
    );
    if (confirmed == true) {
      setState(() => _assistants.remove(a));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 760;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(wide: wide, total: _assistants.length, onAdd: _openAddOffice),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppColors.radiusLg),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: wide
                          ? _AssistantsTable(
                              assistants: _assistants,
                              onView: _openProfile,
                              onEdit: _openEdit,
                              onDelete: _openDelete,
                              onCreateOrder: _openCreateOrder,
                            )
                          : _AssistantsCardList(
                              assistants: _assistants,
                              onView: _openProfile,
                              onEdit: _openEdit,
                              onDelete: _openDelete,
                              onCreateOrder: _openCreateOrder,
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool wide;
  final int total;
  final VoidCallback onAdd;

  const _Header({required this.wide, required this.total, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final title = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Assistants', style: AppText.h1),
        const SizedBox(width: 10),
        Text('Total:', style: AppText.bodyMuted),
        const SizedBox(width: 6),
        Pill(text: '$total', background: AppColors.blueBadgeBg, foreground: AppColors.blue),
      ],
    );

    final search = AppTextField(hint: 'Search here...', prefixIcon: Icons.search);
    final addButton = PrimaryButton(label: 'Add Assistant', icon: Icons.add, onPressed: onAdd);

    if (wide) {
      return Row(
        children: [
          title,
          const Spacer(),
          SizedBox(width: 260, child: search),
          const SizedBox(width: 10),
          addButton,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: search),
            const SizedBox(width: 10),
            addButton,
          ],
        ),
      ],
    );
  }
}

class _NameCell extends StatelessWidget {
  final Assistant assistant;
  const _NameCell({required this.assistant});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.fieldFill,
          child: Icon(Icons.person, size: 16, color: AppColors.textMuted),
        ),
        const SizedBox(width: 8),
        Text(assistant.name, style: AppText.body.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _ActionIcons extends StatelessWidget {
  final Assistant assistant;
  final ValueChanged<Assistant> onView;
  final ValueChanged<Assistant> onEdit;
  final ValueChanged<Assistant> onDelete;
  final ValueChanged<Assistant> onCreateOrder;
  final Color? background;

  const _ActionIcons({
    required this.assistant,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    required this.onCreateOrder,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconCircleButton(
          icon: Icons.add_shopping_cart_outlined,
          color: AppColors.blue,
          background: background,
          onPressed: () => onCreateOrder(assistant),
        ),
        IconCircleButton(
          icon: Icons.visibility_outlined,
          background: background,
          onPressed: () => onView(assistant),
        ),
        IconCircleButton(
          icon: Icons.edit_outlined,
          color: AppColors.green,
          background: background,
          onPressed: () => onEdit(assistant),
        ),
        IconCircleButton(
          icon: Icons.delete_outline,
          color: AppColors.red,
          background: background,
          onPressed: () => onDelete(assistant),
        ),
      ],
    );
  }
}

/// Desktop / tablet: full DataTable matching Image 1 exactly.
class _AssistantsTable extends StatelessWidget {
  final List<Assistant> assistants;
  final ValueChanged<Assistant> onView;
  final ValueChanged<Assistant> onEdit;
  final ValueChanged<Assistant> onDelete;
  final ValueChanged<Assistant> onCreateOrder;

  const _AssistantsTable({
    required this.assistants,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    required this.onCreateOrder,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(AppColors.blueLight),
          headingTextStyle: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.textPrimary),
          dataRowMinHeight: 60,
          dataRowMaxHeight: 68,
          columnSpacing: 32,
          columns: const [
            DataColumn(label: Text('S.N.')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Join Date')),
            DataColumn(label: Text('Action')),
          ],
          rows: assistants.map((a) {
            return DataRow(cells: [
              DataCell(Text('${a.sn}', style: AppText.body)),
              DataCell(_NameCell(assistant: a)),
              DataCell(Text(a.email, style: AppText.body)),
              DataCell(Text(a.phone, style: AppText.body)),
              DataCell(Text(a.joinDate, style: AppText.body)),
              DataCell(_ActionIcons(
                assistant: a,
                onView: onView,
                onEdit: onEdit,
                onDelete: onDelete,
                onCreateOrder: onCreateOrder,
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

/// Mobile layout: card list, fully responsive down to small phone widths.
class _AssistantsCardList extends StatelessWidget {
  final List<Assistant> assistants;
  final ValueChanged<Assistant> onView;
  final ValueChanged<Assistant> onEdit;
  final ValueChanged<Assistant> onDelete;
  final ValueChanged<Assistant> onCreateOrder;

  const _AssistantsCardList({
    required this.assistants,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    required this.onCreateOrder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: assistants.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final a = assistants[i];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppColors.radiusMd),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NameCell(assistant: a),
              const SizedBox(height: 8),
              Text(a.email, style: AppText.bodyMuted),
              Text(a.phone, style: AppText.bodyMuted),
              Text('Joined ${a.joinDate}', style: AppText.bodyMuted),
              const SizedBox(height: 10),
              _ActionIcons(
                assistant: a,
                onView: onView,
                onEdit: onEdit,
                onDelete: onDelete,
                onCreateOrder: onCreateOrder,
                background: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
