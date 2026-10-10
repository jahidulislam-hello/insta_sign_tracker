import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models/technician.dart';


/// Shown when the user presses the eye (view) icon on a row.
/// Read-only, richly detailed profile screen rendered as a popup.
class TechnicianDetailDialog extends StatefulWidget {
  final Technician technician;
  const TechnicianDetailDialog({super.key, required this.technician});

  @override
  State<TechnicianDetailDialog> createState() => _TechnicianDetailDialogState();
}

class _TechnicianDetailDialogState extends State<TechnicianDetailDialog> {
  bool _servicesExpanded = true;
  bool _timeOffExpanded = true;

  @override
  Widget build(BuildContext context) {
    final t = widget.technician;
    return Dialog(
      backgroundColor: AppColors.background,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1020, maxHeight: 820),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 700;
                      final infoCard = _TechnicianInfoCard(technician: t);
                      final additionalCard = _AdditionalInfoCard(technician: t);
                      if (isNarrow) {
                        return Column(children: [infoCard, const SizedBox(height: 16), additionalCard]);
                      }
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: infoCard),
                            const SizedBox(width: 16),
                            Expanded(child: additionalCard),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    const _SectionLabel(text: 'ACTIONS'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.calendar_today, size: 16),
                          label: const Text('Reserve Time'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Delete Technician', style: TextStyle(color: AppColors.textSecondary)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const _SectionLabel(text: 'OTHER'),
                    const SizedBox(height: 10),
                    _CollapsibleCard(
                      title: 'Services & Entry',
                      expanded: _servicesExpanded,
                      onToggle: () => setState(() => _servicesExpanded = !_servicesExpanded),
                      child: LayoutBuilder(builder: (context, constraints) {
                        final isNarrow = constraints.maxWidth < 560;
                        final services = _EntryListColumn(
                          title: 'Allowed Service Categories',
                          important: true,
                          items: t.allowedServiceCategories,
                          icons: const {
                            '3D': Icons.view_in_ar_outlined,
                            'Drone': Icons.flight_outlined,
                            'Editing Only': Icons.content_cut,
                            'Floor Plan': Icons.home_outlined,
                            'Other': Icons.description_outlined,
                            'Photo': Icons.photo_camera_outlined,
                            'Video': Icons.videocam_outlined,
                          },
                          onAdd: () {},
                          onDelete: (i) => setState(() => t.allowedServiceCategories.removeAt(i)),
                        );
                        final entry = _EntryListColumn(
                          title: 'Allowed Entry Methods',
                          important: false,
                          items: t.allowedEntryMethods,
                          icons: const {},
                          onAdd: () {},
                          onDelete: (i) => setState(() => t.allowedEntryMethods.removeAt(i)),
                        );
                        if (isNarrow) {
                          return Column(children: [services, const SizedBox(height: 16), entry]);
                        }
                        return IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: services),
                              const VerticalDivider(width: 32, color: AppColors.border),
                              Expanded(child: entry),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    _CollapsibleCard(
                      title: 'Time Off',
                      expanded: _timeOffExpanded,
                      onToggle: () => setState(() => _timeOffExpanded = !_timeOffExpanded),
                      trailing: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Request Time Off'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Scheduled Time Off',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textPrimary)),
                            ),
                          ),
                          for (int i = 0; i < t.timeOff.length; i++) ...[
                            _TimeOffTile(
                              entry: t.timeOff[i],
                              onDelete: () => setState(() => t.timeOff.removeAt(i)),
                            ),
                            if (i != t.timeOff.length - 1) const SizedBox(height: 10),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: AppColors.textMuted,
      ),
    );
  }
}

class _TechnicianInfoCard extends StatefulWidget {
  final Technician technician;
  const _TechnicianInfoCard({required this.technician});

  @override
  State<_TechnicianInfoCard> createState() => _TechnicianInfoCardState();
}

class _TechnicianInfoCardState extends State<_TechnicianInfoCard> {
  @override
  Widget build(BuildContext context) {
    final t = widget.technician;
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _SectionLabel(text: 'TECHNICIAN INFO'),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined, size: 15, color: AppColors.primaryBlue),
                label: const Text('Edit', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(10, 10)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                  color: AppColors.background,
                ),
                alignment: Alignment.center,
                child: const Text('LOGO', style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text(t.email, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    Row(
                      children: [
                        Text(t.phone, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                        const SizedBox(width: 6),
                        const Icon(Icons.chat_bubble_outline, size: 14, color: Color(0xFF27AE60)),
                      ],
                    ),
                  ],
                ),
              ),
              const Text('Technician, Admin', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _MiniSwitch(
                label: 'Active',
                value: t.isActive,
                onChanged: (v) => setState(() => t.isActive = v),
              ),
              const SizedBox(width: 24),
              _MiniSwitch(
                label: 'Admin',
                value: t.isAdmin,
                onChanged: (v) => setState(() => t.isAdmin = v),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _MiniSwitch({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.primaryBlue,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _AdditionalInfoCard extends StatelessWidget {
  final Technician technician;
  const _AdditionalInfoCard({required this.technician});

  @override
  Widget build(BuildContext context) {
    final t = technician;
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel(text: 'ADDITIONAL INFO'),
          const SizedBox(height: 14),
          _InfoRow(label: 'Last Login', value: t.lastLogin),
          _InfoRow(label: 'User since', value: t.userSince),
          _InfoRow(label: 'Slack Bot Integration', value: t.slackIntegrationStatus, valueColor: AppColors.statusPending),
          _InfoRow(label: 'Calendar Integration', value: t.calendarIntegrationStatus, valueColor: AppColors.statusCompleted),
          _InfoRow(label: 'Launch Location', value: t.launchLocationStatus, valueColor: AppColors.statusAdded),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _CollapsibleCard extends StatelessWidget {
  final String title;
  final bool expanded;
  final VoidCallback onToggle;
  final Widget child;
  final Widget? trailing;

  const _CollapsibleCard({
    required this.title,
    required this.expanded,
    required this.onToggle,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              Row(
                children: [
                  if (trailing != null) ...[trailing!, const SizedBox(width: 10)],
                  InkWell(
                    onTap: onToggle,
                    child: Icon(
                      expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (expanded) ...[
            const SizedBox(height: 16),
            child,
          ],
        ],
      ),
    );
  }
}

class _EntryListColumn extends StatelessWidget {
  final String title;
  final bool important;
  final List<String> items;
  final Map<String, IconData> icons;
  final VoidCallback onAdd;
  final ValueChanged<int> onDelete;

  const _EntryListColumn({
    required this.title,
    required this.important,
    required this.items,
    required this.icons,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            if (important) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(6)),
                child: const Text('IMPORTANT', style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w700)),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                if (icons[items[i]] != null) ...[
                  Icon(icons[items[i]], size: 17, color: AppColors.textSecondary),
                  const SizedBox(width: 10),
                ],
                Expanded(child: Text(items[i], style: const TextStyle(fontSize: 13.5, color: AppColors.textPrimary))),
                InkWell(
                  onTap: () => onDelete(i),
                  child: Icon(Icons.delete_outline, size: 18, color: AppColors.iconDelete),
                ),
              ],
            ),
          ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onAdd,
          child: const Row(
            children: [
              Icon(Icons.add, size: 16, color: AppColors.primaryBlue),
              SizedBox(width: 6),
              Text('Add New', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 13.5)),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeOffTile extends StatelessWidget {
  final TimeOffEntry entry;
  final VoidCallback onDelete;
  const _TimeOffTile({required this.entry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final approved = entry.status == 'APPROVED';
    final iconBg = entry.isVacationType ? const Color(0xFFFCEFE3) : const Color(0xFFE6F0FE);
    final iconColor = entry.isVacationType ? const Color(0xFFF2994A) : AppColors.primaryBlue;
    final statusBg = approved ? const Color(0xFFE7F7EE) : const Color(0xFFFCF3E3);
    final statusColor = approved ? AppColors.statusApproved : AppColors.statusPending;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Icon(Icons.calendar_today_outlined, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                Text(entry.dateRange, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(6)),
            child: Text(entry.status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 10),
          InkWell(onTap: onDelete, child: const Icon(Icons.delete_outline, size: 18, color: AppColors.iconDelete)),
        ],
      ),
    );
  }
}
