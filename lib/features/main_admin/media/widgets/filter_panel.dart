import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';


class FilterPanel extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onApply;
  final VoidCallback onClearAll;

  const FilterPanel({
    super.key,
    required this.onClose,
    required this.onApply,
    required this.onClearAll,
  });

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  bool _expanded = true;
  double _priceRange = 0;

  final _minCtrl = TextEditingController(text: '\$0.00');
  final _maxCtrl = TextEditingController(text: '\$0.00');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 260,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: modalDecoration(radius: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Filtering', style: AppText.sectionHeader),
                const Spacer(),
                InkWell(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: Icon(
                    _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 14),
              _dropdownField('Date Shot', 'All Items'),
              const SizedBox(height: 12),
              _dropdownField('Shot by', '-- Type to search --'),
              const SizedBox(height: 12),
              _dropdownField('Agent', '-- Type to search --'),
              const SizedBox(height: 12),
              _dropdownField('Delivery Phase', 'All'),
              const SizedBox(height: 12),
              _dropdownField('Rushed', ''),
              const SizedBox(height: 12),
              const Text('Listing Price', style: AppText.fieldLabel),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(child: _smallField(_minCtrl)),
                  const SizedBox(width: 8),
                  Expanded(child: _smallField(_maxCtrl)),
                ],
              ),
              const SizedBox(height: 10),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppColors.red,
                  inactiveTrackColor: AppColors.border,
                  thumbColor: AppColors.red,
                  overlayColor: AppColors.red.withOpacity(0.15),
                  trackHeight: 2,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                ),
                child: Slider(
                  value: _priceRange,
                  onChanged: (v) => setState(() => _priceRange = v),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: widget.onClearAll,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Clear All',
                          style: TextStyle(color: AppColors.red, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.onApply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _dropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.fieldLabel),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFB),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: value.startsWith('--')
                        ? AppColors.textMuted
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textMuted),
            ],
          ),
        ),
      ],
    );
  }

  Widget _smallField(TextEditingController c) {
    return TextField(
      controller: c,
      style: const TextStyle(fontSize: 12.5),
      decoration: inputDecoration(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }
}
