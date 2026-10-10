import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'common.dart';

/// "Add New Inventory Item" popup — shown from the Returns tab's
/// "+ New Item" button. Has 3 sub-tabs (Agent / Office / Sign Company);
/// each tab shows the same form (matches screenshot 9).
class NewItemDialog extends StatefulWidget {
  const NewItemDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => const NewItemDialog(),
    );
  }

  @override
  State<NewItemDialog> createState() => _NewItemDialogState();
}

class _NewItemDialogState extends State<NewItemDialog> {
  int tabIndex = 0;
  final tabs = const ['Agent', 'Office', 'Sign Company'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 200),
      child: Container(
        width: 380,
        constraints: const BoxConstraints(maxHeight: 720),
        decoration: modalDecoration(radius: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Add New Inventory Item',
                        style: AppText.dialogTitle),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.redLight,
                      child: Icon(Icons.close,
                          size: 14, color: AppColors.coralRed),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Inventory Type', style: AppText.fieldLabel),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _typeSwitcher(),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // Same form content for all 3 sub-tabs.
                child: _formBody(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
              child: Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      label: 'Close',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Add Item',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _typeSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final selected = i == tabIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => tabIndex = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppColors.radiusSm),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 4,
                              offset: const Offset(0, 1))
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[i],
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? AppColors.primaryBlue
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _formBody() {
    // Identical fields for Agent / Office / Sign Company — only the
    // "Assign Agent" label adapts to the selected inventory type.
    final assignLabel = tabIndex == 0
        ? 'Assign Agent'
        : tabIndex == 1
            ? 'Assign Office'
            : 'Assign Sign Company';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Select Item Category'),
        _dropdown(hint: 'Sign'),
        const SizedBox(height: 12),
        _label('Select Item Type'),
        _dropdown(hint: 'Search To Select'),
        const SizedBox(height: 12),
        _label('Select Shipment'),
        _dropdown(hint: 'Search To Select'),
        const SizedBox(height: 12),
        _label('Unit Price'),
        _textField(hint: 'e.g. \$100.00'),
        const SizedBox(height: 12),
        _label('Warehouse Location'),
        _textField(hint: 'e.g. Dhaka, Bangladesh'),
        const SizedBox(height: 12),
        _label('Serial No'),
        _textField(hint: 'Type Here...'),
        const SizedBox(height: 12),
        _label('Shelve No'),
        _textField(hint: 'Type Here...'),
        const SizedBox(height: 12),
        _label('Quantity'),
        _textField(hint: 'Type Here...', keyboardType: TextInputType.number),
        const SizedBox(height: 12),
        _label('Image'),
        _uploadBox(),
        const SizedBox(height: 12),
        _label('Barcode'),
        _textField(hint: '123456789'),
        const SizedBox(height: 12),
        _label(assignLabel),
        _dropdown(hint: 'Select'),
        const SizedBox(height: 12),
        _label('Notes'),
        _textField(hint: 'Type Here...', maxLines: 3),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: AppText.fieldLabel),
      );

  Widget _textField({
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: inputDecoration(hint: hint),
    );
  }

  Widget _dropdown({required String hint}) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFB),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(hint,
                style:
                    const TextStyle(color: AppColors.textMuted, fontSize: 13)),
          ),
          const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textSecondary, size: 20),
        ],
      ),
    );
  }

  Widget _uploadBox() {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFB),
        borderRadius: BorderRadius.circular(AppColors.radiusSm),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.file_upload_outlined,
              size: 22, color: AppColors.textMuted),
          SizedBox(height: 4),
          Text('Upload Here...',
              style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
