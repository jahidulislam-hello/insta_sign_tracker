import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'common.dart';

/// Pixel-matched delete-confirmation popup (Image 6).
/// Shown when the delete (trash) icon is pressed on an assistant's row.
class DeleteConfirmDialog extends StatefulWidget {
  final String roleLabel;
  const DeleteConfirmDialog({super.key, this.roleLabel = 'team lead'});

  @override
  State<DeleteConfirmDialog> createState() => _DeleteConfirmDialogState();
}

class _DeleteConfirmDialogState extends State<DeleteConfirmDialog> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 400 ? screenWidth - 32 : 360.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: dialogWidth,
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Are you sure you want to delete?',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => setState(() => _confirmed = !_confirmed),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: _confirmed,
                      shape: const CircleBorder(),
                      activeColor: AppColors.blue,
                      onChanged: (v) => setState(() => _confirmed = v ?? false),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        'I confirm that I want to delete this ${widget.roleLabel}.',
                        style: AppText.bodyMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButton(
                  label: 'No',
                  textColor: AppColors.textPrimary,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                const SizedBox(width: 10),
                PrimaryButton(
                  label: 'Yes',
                  color: AppColors.pink,
                  onPressed: _confirmed
                      ? () => Navigator.of(context).pop(true)
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
