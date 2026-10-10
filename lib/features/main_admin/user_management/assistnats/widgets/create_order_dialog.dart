import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models/assistant.dart';
import 'common.dart';

class _ServiceItem {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final bool highlighted;
  final bool isNew;

  const _ServiceItem({
    required this.icon,
    required this.iconBg,
    this.iconColor = Colors.white,
    required this.label,
    this.highlighted = false,
    this.isNew = false,
  });
}

/// Pixel-matched "Create Order" popup (Image 3).
/// Opened from the "Create Order" action next to an assistant's row.
class CreateOrderDialog extends StatelessWidget {
  final Assistant assistant;
  const CreateOrderDialog({super.key, required this.assistant});

  static const _forSaleSigns = [
    _ServiceItem(
      icon: Icons.storefront_outlined,
      iconBg: Color(0xFFDCEEFE),
      iconColor: AppColors.blue,
      label: 'Order New Sign Install',
    ),
    _ServiceItem(
      icon: Icons.print_outlined,
      iconBg: AppColors.fieldFill,
      iconColor: AppColors.textSecondary,
      label: 'Order Sign Printing',
    ),
    _ServiceItem(
      icon: Icons.cancel,
      iconBg: Color(0xFFEF5350),
      iconColor: Colors.white,
      label: 'Order Sign Removal',
    ),
    _ServiceItem(
      icon: Icons.swap_horiz,
      iconBg: AppColors.fieldFill,
      iconColor: AppColors.textSecondary,
      label: 'Order Sign Change Request',
    ),
  ];

  static const _otherServices = [
    _ServiceItem(
      icon: Icons.signpost_outlined,
      iconBg: Color(0xFFFCE4EC),
      iconColor: Color(0xFFE91E63),
      label: 'Order For Sale Directionals',
    ),
    _ServiceItem(
      icon: Icons.home_outlined,
      iconBg: AppColors.green,
      iconColor: Colors.white,
      label: 'Order Open House Services',
      highlighted: true,
    ),
    _ServiceItem(
      icon: Icons.camera_alt_outlined,
      iconBg: Color(0xFF37474F),
      iconColor: Colors.white,
      label: 'Order Media Services',
    ),
    _ServiceItem(
      icon: Icons.apps,
      iconBg: Color(0xFFEDE7F6),
      iconColor: Color(0xFF7E57C2),
      label: 'Other Services',
      isNew: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final narrow = screenWidth < 640;
    final dialogWidth = narrow ? screenWidth - 32 : 640.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: dialogWidth,
        constraints: const BoxConstraints(maxHeight: 620),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
              child: Row(
                children: [
                  const Text('Create Order',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary)),
                  const Spacer(),
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.fieldFill,
                    child:
                        const Icon(Icons.person, size: 16, color: AppColors.textMuted),
                  ),
                  const SizedBox(width: 8),
                  Text(assistant.name,
                      style: const TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                  const Spacer(),
                  IconCircleButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: narrow
                    ? Column(
                        children: [
                          _column('For Sale Signs', _forSaleSigns, context),
                          const SizedBox(height: 20),
                          _column('Other Services', _otherServices, context),
                        ],
                      )
                    : IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: _column(
                                    'For Sale Signs', _forSaleSigns, context)),
                            const SizedBox(width: 24),
                            Expanded(
                                child: _column(
                                    'Other Services', _otherServices, context)),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _column(String title, List<_ServiceItem> items, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        const Divider(height: 1, color: AppColors.border),
        const SizedBox(height: 12),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _serviceRow(item, context),
          ),
      ],
    );
  }

  Widget _serviceRow(_ServiceItem item, BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppColors.radiusMd),
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: item.highlighted ? AppColors.greenLight : Colors.white,
          border: Border.all(
              color: item.highlighted ? AppColors.green : AppColors.border),
          borderRadius: BorderRadius.circular(AppColors.radiusMd),
        ),
        child: Row(
          children: [
            ServiceIcon(
                icon: item.icon,
                background: item.iconBg,
                iconColor: item.iconColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(item.label,
                  style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
            ),
            if (item.isNew) ...[
              const Pill(
                  text: 'NEW',
                  background: AppColors.fieldFill,
                  foreground: AppColors.textSecondary),
              const SizedBox(width: 8),
            ],
            const Icon(Icons.chevron_right, size: 20, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
