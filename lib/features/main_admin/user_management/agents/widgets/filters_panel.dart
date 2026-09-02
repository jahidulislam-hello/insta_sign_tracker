import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'common.dart';
import 'add_filter_dialog.dart';

enum FilterTab { predefined, mine, favorites }

/// Pixel-matched "Filters" side popup (Image 3).
/// Opened as a right-anchored panel when the "Filter" button is pressed.
/// Contains a 3-icon tab system (funnel / person / star) and, at the
/// bottom, the "+ Add Filter" action that opens [AddFilterDialog].
class FiltersPanel extends StatefulWidget {
  const FiltersPanel({super.key});

  @override
  State<FiltersPanel> createState() => _FiltersPanelState();
}

class _FiltersPanelState extends State<FiltersPanel> {
  FilterTab _tab = FilterTab.predefined;
  int? _selected;

  static const _predefined = [
    'New Clients (First Order in Last 30 Days)',
    'At-Risk Clients (Non-VIP, 120 Days Inactive)',
    'Lost Clients (Non-VIP, 180+ Days Inactive)',
    'At-Risk VIP Clients (No Orders in 60 Days)',
    'Lost VIP Clients (No Orders in 90 Days)',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final panelWidth = screenWidth < 420 ? screenWidth - 32 : 320.0;

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 70, right: 16),
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: panelWidth,
            constraints: const BoxConstraints(maxHeight: 520),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppColors.radiusLg),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('FILTERS', style: AppText.sectionLabel),
                    IconCircleButton(
                      icon: Icons.keyboard_arrow_up,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _TabBar(
                  value: _tab,
                  onChanged: (t) => setState(() => _tab = t),
                ),
                const SizedBox(height: 12),
                const AppTextField(
                  hint: 'Search filters',
                  prefixIcon: Icons.search,
                ),
                const SizedBox(height: 16),
                const Text('PREDEFINED FILTERS', style: AppText.sectionLabel),
                const SizedBox(height: 8),
                Flexible(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _predefined.length,
                      separatorBuilder: (_, __) => const Divider(
                          height: 20, color: AppColors.border),
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () => setState(() => _selected = i),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(_predefined[i],
                                    style: AppText.body),
                              ),
                              const SizedBox(width: 8),
                              Radio<int>(
                                value: i,
                                groupValue: _selected,
                                activeColor: AppColors.blue,
                                onChanged: (v) =>
                                    setState(() => _selected = v),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Divider(height: 24, color: AppColors.border),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => const AddFilterDialog(),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 18, color: AppColors.blue),
                      SizedBox(width: 6),
                      Text('Add Filter',
                          style: TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final FilterTab value;
  final ValueChanged<FilterTab> onChanged;

  const _TabBar({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
      ),
      child: Row(
        children: [
          _tabIcon(Icons.filter_alt_outlined, FilterTab.predefined),
          _tabIcon(Icons.person_outline, FilterTab.mine),
          _tabIcon(Icons.star_border, FilterTab.favorites),
        ],
      ),
    );
  }

  Widget _tabIcon(IconData icon, FilterTab tab) {
    final selected = value == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: selected
                ? const [
                    BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 4,
                        offset: Offset(0, 1))
                  ]
                : null,
          ),
          child: Icon(icon,
              size: 18,
              color: selected ? AppColors.blue : AppColors.textSecondary),
        ),
      ),
    );
  }
}
