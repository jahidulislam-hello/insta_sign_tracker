import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models.dart';
import '../widgets/common.dart';

class AgentTab extends StatelessWidget {
  final List<AgentSummary> agents;
  const AgentTab({super.key, required this.agents});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InventorySearchField(hint: 'Search...'),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            const gap = 16.0;
            final columns = constraints.maxWidth > 900 ? 3 : 1;
            final cardWidth =
                (constraints.maxWidth - gap * (columns - 1)) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: agents
                  .map((a) => SizedBox(
                        width: cardWidth,
                        child: _AgentCard(agent: a),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _AgentCard extends StatelessWidget {
  final AgentSummary agent;
  const _AgentCard({required this.agent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AgentAvatar(size: 36),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(agent.name, style: AppText.cardTitle),
                    Text(
                      '${agent.itemTypes} item types · ${agent.totalUnits} total units',
                      style: AppText.cardSubtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: AppColors.border),
          Row(
            children: [
              _stat('Total Items', '${agent.totalItems}'),
              _stat('Checked out', '${agent.checkedOut}'),
              _stat('Total QTY', '${agent.totalQty}'),
            ],
          ),
          const SizedBox(height: 16),
          ...agent.lines.map((line) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(line.name, style: AppText.cell),
                          Text('${line.category} · ${line.location}',
                              style: AppText.cardSubtitle),
                        ],
                      ),
                    ),
                    Text('${line.qty}', style: AppText.cell),
                    const SizedBox(width: 8),
                    StatusChip(
                      label: line.status,
                      colors: line.status == 'In Stock'
                          ? StatusBadge.inStock
                          : StatusBadge.outOfStock,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.cardSubtitle),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
