import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models/agent.dart';
import '../widgets/common.dart';
import '../widgets/add_agent_dialog.dart';
import '../widgets/filters_panel.dart';
import '../widgets/column_management_dialog.dart';

class AgentsScreen extends StatefulWidget {
  const AgentsScreen({super.key});

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  final List<Agent> _agents = Agent.sample;
  bool _filtersOpen = false;

  void _openAddAgent() {
    showDialog(context: context, builder: (_) => const AddAgentDialog());
  }

  void _openColumnManagement() {
    showDialog(context: context, builder: (_) => const ColumnManagementDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 900;
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Header(
                        wide: wide,
                        agentCount: _agents.length,
                        onCreateAgent: _openAddAgent,
                        onFilterTap: () => setState(() => _filtersOpen = !_filtersOpen),
                        onGridTap: _openColumnManagement,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppColors.radiusLg),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: wide
                              ? _AgentsTable(agents: _agents)
                              : _AgentsCardList(agents: _agents),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (_filtersOpen)
              GestureDetector(
                onTap: () => setState(() => _filtersOpen = false),
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  width: double.infinity,
                  height: double.infinity,
                  child: const FiltersPanel(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool wide;
  final int agentCount;
  final VoidCallback onCreateAgent;
  final VoidCallback onFilterTap;
  final VoidCallback onGridTap;

  const _Header({
    required this.wide,
    required this.agentCount,
    required this.onCreateAgent,
    required this.onFilterTap,
    required this.onGridTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleRow = Row(
      children: [
        const Text('Agents', style: AppText.h1),
        const SizedBox(width: 10),
        const Pill(text: 'CRM Grid', background: AppColors.chipBlack, foreground: Colors.white),
        const SizedBox(width: 14),
        PrimaryButton(label: 'Create Agent', icon: Icons.add, onPressed: onCreateAgent),
        const SizedBox(width: 14),
        Text('You have $agentCount agents', style: AppText.bodyMuted),
      ],
    );

    final toolsRow = Row(
      children: [
        Expanded(
          child: AppTextField(hint: 'Search', prefixIcon: Icons.search),
        ),
        const SizedBox(width: 10),
        _FilterButton(onTap: onFilterTap),
        const SizedBox(width: 10),
        IconCircleButton(
          icon: Icons.grid_view,
          background: AppColors.fieldFill,
          onPressed: onGridTap,
        ),
        const SizedBox(width: 6),
        const IconCircleButton(icon: Icons.more_horiz, background: AppColors.fieldFill),
      ],
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: titleRow)),
          SizedBox(width: 420, child: toolsRow),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            const Text('Agents', style: AppText.h1),
            const Pill(text: 'CRM Grid', background: AppColors.chipBlack, foreground: Colors.white),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            PrimaryButton(label: 'Create Agent', icon: Icons.add, onPressed: onCreateAgent),
            const SizedBox(width: 12),
            Text('You have $agentCount agents', style: AppText.bodyMuted),
          ],
        ),
        const SizedBox(height: 12),
        toolsRow,
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  final VoidCallback onTap;
  const _FilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppColors.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppColors.radiusMd),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filter', style: AppText.body),
            SizedBox(width: 6),
            Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

/// Desktop / tablet layout: full DataTable, horizontally scrollable.
class _AgentsTable extends StatelessWidget {
  final List<Agent> agents;
  const _AgentsTable({required this.agents});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(AppColors.blueLight),
          headingTextStyle: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.textPrimary),
          dataRowMinHeight: 64,
          dataRowMaxHeight: 88,
          columnSpacing: 24,
          columns: const [
            DataColumn(label: Text('S.N.')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Join Date')),
            DataColumn(label: Text('Brokerage')),
            DataColumn(label: Text('Tags')),
            DataColumn(label: Text('Last Contact Date')),
            DataColumn(label: Text('Next Contact Date')),
            DataColumn(label: Text('Contact Note')),
            DataColumn(label: Text('Create Order')),
            DataColumn(label: Text('Action')),
          ],
          rows: agents.map((a) {
            return DataRow(cells: [
              DataCell(Text('${a.sn}', style: AppText.body)),
              DataCell(_NameCell(agent: a)),
              DataCell(Text(a.email, style: AppText.body)),
              DataCell(Text(a.phone, style: AppText.body)),
              DataCell(Text(a.joinDate, style: AppText.body)),
              DataCell(_BrokerageCell(brokerage: a.brokerage)),
              DataCell(a.tag == null
                  ? const Text('-', style: AppText.bodyMuted)
                  : Pill(text: a.tag!, background: AppColors.orangeLight, foreground: AppColors.orange)),
              DataCell(Text(a.lastContactDate ?? 'MM/DD/YYYY',
                  style: a.lastContactDate == null ? AppText.bodyMuted : AppText.body)),
              DataCell(Text(a.nextContactDate ?? 'MM/DD/YYYY',
                  style: a.nextContactDate == null ? AppText.bodyMuted : AppText.body)),
              DataCell(SizedBox(
                width: 220,
                child: a.contactNote.isEmpty
                    ? const Icon(Icons.chat_bubble_outline, size: 16, color: AppColors.red)
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.red),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(a.contactNote,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: AppText.body),
                          ),
                        ],
                      ),
              )),
              DataCell(PrimaryButton(label: 'Create Order', onPressed: () {})),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconCircleButton(icon: Icons.visibility_outlined, onPressed: () {}),
                  IconCircleButton(icon: Icons.edit_outlined, color: AppColors.green, onPressed: () {}),
                  IconCircleButton(icon: Icons.delete_outline, color: AppColors.red, onPressed: () {}),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

class _NameCell extends StatelessWidget {
  final Agent agent;
  const _NameCell({required this.agent});

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
        if (agent.hasLocationPin) ...[
          const Icon(Icons.location_on, size: 14, color: AppColors.blue),
          const SizedBox(width: 4),
        ],
        Text(agent.name, style: AppText.body.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _BrokerageCell extends StatelessWidget {
  final String brokerage;
  const _BrokerageCell({required this.brokerage});

  @override
  Widget build(BuildContext context) {
    if (brokerage == 'None') {
      return const Text('None', style: AppText.bodyMuted);
    }
    IconData icon = Icons.shield_outlined;
    if (brokerage == 'RE/MAX') icon = Icons.location_on;
    if (brokerage == 'Keller Williams') icon = Icons.circle;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.blue),
        const SizedBox(width: 6),
        Text(brokerage, style: AppText.body),
      ],
    );
  }
}

/// Mobile layout: card list, one card per agent, fully responsive.
class _AgentsCardList extends StatelessWidget {
  final List<Agent> agents;
  const _AgentsCardList({required this.agents});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: agents.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final a = agents[i];
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
              Row(
                children: [
                  _NameCell(agent: a),
                  const Spacer(),
                  if (a.tag != null)
                    Pill(text: a.tag!, background: AppColors.orangeLight, foreground: AppColors.orange),
                ],
              ),
              const SizedBox(height: 10),
              Text(a.email, style: AppText.bodyMuted),
              Text(a.phone, style: AppText.bodyMuted),
              const SizedBox(height: 6),
              _BrokerageCell(brokerage: a.brokerage),
              if (a.contactNote.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(Icons.chat_bubble_outline, size: 14, color: AppColors.red),
                    ),
                    const SizedBox(width: 6),
                    Expanded(child: Text(a.contactNote, style: AppText.body)),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: PrimaryButton(label: 'Create Order', expand: true, onPressed: () {})),
                  const SizedBox(width: 8),
                  IconCircleButton(icon: Icons.visibility_outlined, background: Colors.white, onPressed: () {}),
                  IconCircleButton(icon: Icons.edit_outlined, color: AppColors.green, background: Colors.white, onPressed: () {}),
                  IconCircleButton(icon: Icons.delete_outline, color: AppColors.red, background: Colors.white, onPressed: () {}),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
