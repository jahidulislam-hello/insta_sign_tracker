import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models/assistant.dart';
import 'common.dart';

/// Pixel-matched profile popup (Image 4).
/// Shown when the eye (view) icon is pressed on an assistant's row.
class ProfileDialog extends StatelessWidget {
  final Assistant assistant;
  const ProfileDialog({super.key, required this.assistant});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 420 ? screenWidth - 32 : 380.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: dialogWidth,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconCircleButton(
                icon: Icons.close,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            CircleAvatar(
              radius: 34,
              backgroundColor: AppColors.blue,
              child: Text(
                assistant.initials,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 12),
            Text(assistant.name,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 2),
            Text(assistant.role, style: AppText.bodyMuted),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _iconLine(Icons.mail_outline, assistant.email),
                  const SizedBox(height: 10),
                  _iconLine(Icons.call_outlined, assistant.phone),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 12),
            _statRow('TOTAL ORDERS', '${assistant.totalOrders}'),
            const SizedBox(height: 10),
            _statRow('TOTAL AGENT', '${assistant.totalAgent}'),
            const SizedBox(height: 10),
            _statRow('INVENTORY ITEMS', '${assistant.inventoryItems}'),
            const SizedBox(height: 10),
            _statRow('OFFICE', assistant.office, valueBold: true),
            const SizedBox(height: 10),
            _statRow('BROKERAGE', assistant.brokerage, valueBold: true),
          ],
        ),
      ),
    );
  }

  Widget _iconLine(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Text(text, style: AppText.body),
      ],
    );
  }

  Widget _statRow(String label, String value, {bool valueBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppText.sectionLabel),
        Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: valueBold ? FontWeight.w700 : FontWeight.w800,
                color: AppColors.textPrimary)),
      ],
    );
  }
}
