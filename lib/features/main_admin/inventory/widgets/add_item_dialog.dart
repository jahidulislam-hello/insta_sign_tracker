import 'package:flutter/material.dart';
import 'package:insta_sign_tracker/core/utils/app_colors.dart';
import 'common.dart';

/// "Add Item" popup — shown when the header's "+ Add Item" button is
/// pressed from the Table View tab. Matches screenshot 2.
class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => const AddItemDialog(),
    );
  }

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  String? itemType;
  String assignToType = 'Agent';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        width: 560,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
        decoration: modalDecoration(radius: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                    child: Text('Add Item', style: AppText.dialogTitle)),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close,
                      size: 20, color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 18),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upload image box
                  _UploadImageBox(),
                  const SizedBox(width: 20),
                  // Form fields
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Item Name'),
                        _textField(hint: 'e.g. Red Sold Rider'),
                        const SizedBox(height: 12),
                        _label('Item Description'),
                        _textField(
                          hint: 'Enter item description',
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Item Type'),
                      _dropdown(
                        hint: 'Select Type',
                        value: itemType,
                        items: const ['Sign post', 'Main Panel', 'Rider'],
                        onChanged: (v) => setState(() => itemType = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Assign To Type'),
                      _dropdown(
                        hint: 'Agent',
                        value: assignToType,
                        items: const ['Agent', 'Office', 'Warehouse'],
                        onChanged: (v) =>
                            setState(() => assignToType = v ?? 'Agent'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _label('Assigned Agent'),
            _textField(hint: 'e.g. John Doe'),
            const SizedBox(height: 12),
            _label('Quantity'),
            _textField(hint: 'e.g. 10', keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Material'),
                      _textField(hint: 'e.g. Aluminum'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Color'),
                      _textField(hint: 'e.g. White'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Height'),
                      _textField(hint: 'e.g. 72 inches'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Mounting Type'),
                      _textField(hint: 'e.g. Ground'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close',
                      style: TextStyle(color: AppColors.blueLink)),
                ),
                const SizedBox(width: 8),
                PrimaryButton(
                  label: 'Add',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ],
        ),
      ),
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

  Widget _dropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFB),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(hint,
              style: const TextStyle(
                  color: AppColors.textMuted, fontSize: 13)),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textSecondary, size: 20),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _UploadImageBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 190,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFB),
        borderRadius: BorderRadius.circular(AppColors.radiusMd),
        border: Border.all(
            color: AppColors.borderStrong,
            style: BorderStyle.solid,
            width: 1),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.file_upload_outlined,
              size: 26, color: AppColors.textMuted),
          SizedBox(height: 8),
          Text('Upload Image',
              style: TextStyle(fontSize: 12.5, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
