import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import '../models/assistant.dart';
import 'common.dart';

/// Pixel-matched "Edit Office" popup (Image 5).
/// Shown when the edit (pencil) icon is pressed on an assistant's row.
/// Fields come pre-filled with the assistant's current data.
class EditOfficeDialog extends StatefulWidget {
  final Assistant assistant;
  const EditOfficeDialog({super.key, required this.assistant});

  @override
  State<EditOfficeDialog> createState() => _EditOfficeDialogState();
}

class _EditOfficeDialogState extends State<EditOfficeDialog> {
  late final TextEditingController _name =
      TextEditingController(text: widget.assistant.name);
  late final TextEditingController _email =
      TextEditingController(text: widget.assistant.email);
  late final TextEditingController _phone =
      TextEditingController(text: widget.assistant.phone);
  late final TextEditingController _office =
      TextEditingController(text: widget.assistant.office);
  late String? _brokerage = widget.assistant.brokerage;

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
                  const Text('Edit Office',
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
                  value: _brokerages.contains(_brokerage) ? _brokerage : null,
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
                final saveBtn = PrimaryButton(
                  label: 'Save Changes',
                  expand: stacked,
                  onPressed: () => Navigator.of(context).pop(),
                );
                if (stacked) {
                  return Column(
                      children: [saveBtn, const SizedBox(height: 10), closeBtn]);
                }
                return Row(
                  children: [
                    Expanded(child: closeBtn),
                    const SizedBox(width: 12),
                    Expanded(child: saveBtn),
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
