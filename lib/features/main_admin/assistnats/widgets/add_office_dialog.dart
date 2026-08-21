import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'common.dart';

/// Pixel-matched "Add Office" popup (Image 2).
/// Shown when the user taps "+ Add Assistant" on the Assistants screen.
class AddOfficeDialog extends StatefulWidget {
  const AddOfficeDialog({super.key});

  @override
  State<AddOfficeDialog> createState() => _AddOfficeDialogState();
}

class _AddOfficeDialogState extends State<AddOfficeDialog> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _office = TextEditingController();
  String? _brokerage;

  static const _brokerages = [
    'Brokerage Office',
    'Real Estate Office',
    'Coldwell Banker',
    'RE/MAX',
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _office.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 480 ? screenWidth - 32 : 380.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: dialogWidth,
        constraints: const BoxConstraints(maxHeight: 640),
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppColors.radiusLg),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Add Office',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary)),
                  IconCircleButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              FieldBlock(
                  label: 'Name',
                  child: AppTextField(hint: 'Type here..', controller: _name)),
              const SizedBox(height: 14),
              FieldBlock(
                  label: 'Email',
                  child: AppTextField(hint: 'Type here..', controller: _email)),
              const SizedBox(height: 14),
              FieldBlock(
                  label: 'Phone',
                  child: AppTextField(hint: 'Type here..', controller: _phone)),
              const SizedBox(height: 14),
              FieldBlock(
                  label: 'Office',
                  child:
                      AppTextField(hint: 'Type here..', controller: _office)),
              const SizedBox(height: 14),
              FieldBlock(
                label: 'Brokerage',
                child: AppDropdown<String>(
                  hint: 'Select Brokerage',
                  value: _brokerage,
                  items: _brokerages
                      .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                      .toList(),
                  onChanged: (v) => setState(() => _brokerage = v),
                ),
              ),
              const SizedBox(height: 24),
              LayoutBuilder(builder: (context, constraints) {
                final stacked = constraints.maxWidth < 340;
                final closeBtn = SecondaryButton(
                  label: 'Close',
                  expand: stacked,
                  onPressed: () => Navigator.of(context).pop(),
                );
                final addBtn = PrimaryButton(
                  label: 'Add',
                  expand: stacked,
                  onPressed: () => Navigator.of(context).pop(),
                );
                if (stacked) {
                  return Column(
                      children: [addBtn, const SizedBox(height: 10), closeBtn]);
                }
                return Row(
                  children: [
                    Expanded(child: closeBtn),
                    const SizedBox(width: 12),
                    Expanded(child: addBtn),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
